-- Insert into departments
INSERT INTO departments (name) VALUES 
    ('Engineering'), 
    ('Sales'), 
    ('Finance'), 
    ('Legal');

-- Insert into roles
INSERT INTO roles (title, salary, department_id) VALUES 
    ('Engineering Manager', 50000, 1),
    ('Lead Engineer', 50000, 1), 
    ('Engineer', 45000, 1),
    ('Sales Manager', 80000, 2),
    ('Sales Supervisor', 60000, 2),
    ('Sales Associate', 80000, 2),
    ('Finance Manager', 120000, 3), 
    ('Finance Specialist', 100000, 3),
    ('Finance Associate', 85000, 3),
    ('Legal Manager', 80000, 4),
    ('Lawyer', 120000, 4),
    ('Legal Specialist', 90000, 4);

-- Now insert managers (these employees will have manager_id set as NULL)
INSERT INTO employees (first_name, last_name, role_id, manager_id, salary) VALUES 
    ('Sarah', 'Brooks', 7, NULL, 90000),  -- Finance Manager (manager_id = NULL)
    ('Jay', 'Elliott', 4, NULL, 95000),   -- Sales Manager (manager_id = NULL)
    ('Jason', 'Brooks', 1, NULL, 100000), -- Engineering Manager (manager_id = NULL)
    ('Rosemary', 'Proctor', 10, NULL, 105000); -- Legal Manager (manager_id = NULL)

-- Insert employees (assigning the manager_id correctly)
INSERT INTO employees (first_name, last_name, role_id, manager_id, salary) VALUES 
    ('Jill', 'Anderson', 8, 1, 55000),     -- Finance Specialist (Reports to Sarah Brooks)
    ('Charlie', 'Murphy', 9, 1, 45000),    -- Finance Associate (Reports to Sarah Brooks)
    ('Jessica', 'Rodriquez', 5, 4, 60000), -- Sales Supervisor (Reports to Jay Elliott)
    ('Daniel', 'Capella', 6, 4, 50000),    -- Sales Associate (Reports to Jay Elliott)
    ('Judy', 'Anderson', 2, 7, 80000),     -- Lead Engineer (Reports to Jason Brooks)
    ('Jenny', 'Gump', 3, 7, 70000),        -- Engineer (Reports to Jason Brooks)
    ('Arya', 'Proctor', 11, 10, 75000),    -- Lawyer (Reports to Rosemary Proctor)
    ('Jon', 'Brooks', 12, 10, 65000);      -- Legal Specialist (Reports to Rosemary Proctor)




