INSERT INTO departments (name) VALUES 
    ('Engineering'), 
    ('Sales'), 
    ('Finance'), 
    ('Legal');
    


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
    

INSERT INTO employees (first_name, last_name, role_id, manager_id) VALUES 
    ('Sarah', 'Brooks', 1, NULL),
    ('Jill', 'Anderson', 2, 1),
    ('Charlie', 'Murphy', 3, 1),
    ('Jay', 'Elliott', 4, NULL),
    ('Jessica', 'Rodriquez', 5, 1),
    ('Daniel', 'Capella', 6, 1),
    ('Jason', 'Brooks', 7, NULL),
    ('Judy', 'Anderson', 8, 7),
    ('Jenny', 'Gump', 9, 7),
    ('Rosemary', 'Proctor', 10, NULL),
    ('Arya', 'Proctor', 11, 10),
    ('Jon', 'Brooks', 12, 10);
    
    

