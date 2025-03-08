SELECT * FROM departments;

// Query to view all roles
SELECT * FROM roles;
SELECT role_id, title, salary, department_id, employee_id FROM roles;
JOIN departments ON roles.department_id = departments.id;

// Query to view all employees
SELECT * FROM employees;
SELECT employee_id, first_name, last_name, role_id, manager_id FROM employees;
JOIN roles ON employees.role_id = roles.id;
JOIN departments ON roles.department_id = departments.id;
LEFT JOIN employees AS manager ON employees.manager_id = manager.employee_id;

// Query to view all employees by department
SELECT department_id, name, title, salary, first_name, last_name FROM departments;
JOIN roles ON departments.id = roles.department_id;
JOIN employees ON roles.id = employees.role_id;

// Query to Add a department
INSERT INTO departments (name) VALUES ('Customer Service');

// Query to Add a role
INSERT INTO roles (title, salary, department_id) VALUES ('Customer Service Manager', 80000, 7);

// Query to Add an employee
INSERT INTO employees (first_name, last_name, role_id, manager_id) VALUES ('John', 'Doe', 7, 1);

// Query to Update an employee role
UPDATE employees SET role_id = 7 WHERE first_name = 'John' AND last_name = 'Doe';

// Query to Update an employee manager
UPDATE employees SET manager_id = 1 WHERE first_name = 'John' AND last_name = 'Doe';

// 

