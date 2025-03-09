-- View all departments
SELECT * FROM departments;

-- View all roles with department names
SELECT 
    roles.id AS role_id, 
    roles.title, 
    roles.salary, 
    roles.department_id, 
    departments.name AS department_name
FROM roles
JOIN departments ON roles.department_id = departments.id;

-- View all employees with their roles and departments
SELECT 
    employees.id AS employee_id, 
    employees.first_name, 
    employees.last_name, 
    roles.title AS role_title, 
    roles.salary, 
    departments.name AS department_name
FROM employees
JOIN roles ON employees.role_id = roles.id
JOIN departments ON roles.department_id = departments.id;

-- View all employees with their managers
SELECT 
    e.id AS employee_id, 
    e.first_name AS employee_first_name, 
    e.last_name AS employee_last_name, 
    r.title AS role_title, 
    d.name AS department_name,
    COALESCE(m.first_name || ' ' || m.last_name, 'No Manager') AS manager_name
FROM employees e
JOIN roles r ON e.role_id = r.id
JOIN departments d ON r.department_id = d.id
LEFT JOIN employees m ON e.manager_id = m.id;

-- View all employees by department
SELECT 
    d.id AS department_id, 
    d.name AS department_name, 
    r.title AS role_title, 
    r.salary, 
    e.first_name, 
    e.last_name
FROM departments d
JOIN roles r ON d.id = r.department_id
JOIN employees e ON r.id = e.role_id;

-- Create a view for employee details
CREATE VIEW employee_details AS 
SELECT 
    e.id AS employee_id, 
    e.first_name, 
    e.last_name, 
    r.title AS role_title, 
    r.salary, 
    d.name AS department_name, 
    COALESCE(m.first_name || ' ' || m.last_name, 'No Manager') AS manager_name
FROM employees e
JOIN roles r ON e.role_id = r.id
JOIN departments d ON r.department_id = d.id
LEFT JOIN employees m ON e.manager_id = m.id;

-- Add a new department safely
BEGIN TRANSACTION;
INSERT INTO departments (name) VALUES ('Customer Service');
COMMIT;

-- Add a new role in a department dynamically
BEGIN TRANSACTION;
INSERT INTO roles (title, salary, department_id) 
VALUES ('Customer Service Manager', 80000, (SELECT id FROM departments WHERE name = 'Customer Service'));
COMMIT;

-- Add a new employee dynamically
BEGIN TRANSACTION;
INSERT INTO employees (first_name, last_name, role_id, manager_id) 
VALUES ('John', 'Doe', 
    (SELECT id FROM roles WHERE title = 'Customer Service Manager'), 
    (SELECT id FROM employees WHERE first_name = 'Sarah' AND last_name = 'Brooks'));
COMMIT;

-- Update an employee's role
UPDATE employees 
SET role_id = (SELECT id FROM roles WHERE title = 'Customer Service Manager')
WHERE first_name = 'John' AND last_name = 'Doe';

-- Update an employee's manager
UPDATE employees 
SET manager_id = (SELECT id FROM employees WHERE first_name = 'Sarah' AND last_name = 'Brooks')
WHERE first_name = 'John' AND last_name = 'Doe';

-- View employee details using the view
SELECT * FROM employee_details;

-- If deleting departments, roles, or employees
-- Delete a department and its roles
BEGIN TRANSACTION;
DELETE FROM departments WHERE name = 'Customer Service';
DELETE FROM roles WHERE department_id = (SELECT id FROM departments WHERE name = 'Customer Service');
COMMIT;

-- Delete a role
BEGIN TRANSACTION;
DELETE FROM roles WHERE title = 'Customer Service Manager';
COMMIT;

-- Delete an employee
BEGIN TRANSACTION;
DELETE FROM employees WHERE first_name = 'John' AND last_name = 'Doe';
COMMIT;

-- Summary report: Count employees per department
SELECT 
    d.name AS department_name, 
    COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN roles r ON d.id = r.department_id
LEFT JOIN employees e ON r.id = e.role_id
GROUP BY d.name;

-- Summary report: Total salary by department
SELECT 
    d.name AS department_name, 
    SUM(r.salary) AS total_salary
FROM departments d
JOIN roles r ON d.id = r.department_id
JOIN employees e ON r.id = e.role_id
GROUP BY d.name;

-- View employee details ordered by department name
SELECT * FROM employee_details
ORDER BY department_name, employee_first_name, employee_last_name;

-- Delete an employee dynamically (additional functionality)
BEGIN TRANSACTION;
DELETE FROM employees WHERE id = (SELECT id FROM employees WHERE first_name = 'John' AND last_name = 'Doe');
COMMIT;

-- Delete a department dynamically (additional functionality)
BEGIN TRANSACTION;
DELETE FROM departments WHERE name = 'Customer Service';
COMMIT;

-- Delete a role dynamically (additional functionality)
BEGIN TRANSACTION;
DELETE FROM roles WHERE title = 'Customer Service Manager';
COMMIT;

-- View employees by manager (additional functionality)
SELECT 
    e.id AS employee_id, 
    e.first_name AS employee_first_name, 
    e.last_name AS employee_last_name, 
    r.title AS role_title, 
    d.name AS department_name,
    COALESCE(m.first_name || ' ' || m.last_name, 'No Manager') AS manager_name
FROM employees e
JOIN roles r ON e.role_id = r.id
JOIN departments d ON r.department_id = d.id
LEFT JOIN employees m ON e.manager_id = m.id
WHERE m.id = (SELECT id FROM employees WHERE first_name = 'Sarah' AND last_name = 'Brooks');

-- View employees by department (additional functionality)
SELECT 
    e.id AS employee_id, 
    e.first_name AS employee_first_name, 
    e.last_name AS employee_last_name, 
    r.title AS role_title, 
    d.name AS department_name
FROM employees e
JOIN roles r ON e.role_id = r.id
JOIN departments d ON r.department_id = d.id
WHERE d.name = 'Customer Service';

-- Summary report: Count employees per department (additional functionality)
SELECT 
    d.name AS department_name, 
    COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN roles r ON d.id = r.department_id
LEFT JOIN employees e ON r.id = e.role_id
GROUP BY d.name
ORDER BY employee_count DESC;

-- Summary report: Total salary by department (additional functionality)
SELECT 
    d.name AS department_name, 
    SUM(r.salary) AS total_salary
FROM departments d
JOIN roles r ON d.id = r.department_id
JOIN employees e ON r.id = e.role_id
GROUP BY d.name
ORDER BY total_salary DESC;
