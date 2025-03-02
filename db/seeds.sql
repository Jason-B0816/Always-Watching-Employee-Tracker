INSERT INTO departments (name) VALUES 
('Human Resources', 1),
('Engineering', 2),
('Product Management', 3),
('Sales', 4),
('Finance', 5),
('Legal', 6);

// Role Table for Human Resources
INSERT INTO roles (title, salary, department_id, employee_id) VALUES 
('HR Manager', 100000, 1, 0001),
('HR Recruiter', 60000, 1, 0002),
('HR Assistant', 40000, 1, 0003),

// Role Table for Engineering
('Engineering Manager', 120000, 2, 0004),
('Software Engineer', 80000, 2, 0005,
('Product Owner', 90000, 2, 0006),
('Senior Product Manager', 110000, 2, 0007),
('Product Manager', 100000, 2, 0008),
('Product Engineer', 70000, 2, 0009),
('Product Analyst', 75000, 2, 0010)
('Product Specialist', 60000, 2, 0011),

// Role Table for Product Management
('Product Manager', 120000, 3, 0012),
('Product Owner', 110000, 3, 0013),
('Product Manager', 110000, 3, 0014),
('Product Manager', 100000, 3, 0015),
('Product Manager', 90000, 3, 0016),
('Product Analyst', 80000, 3, 0017),
('Product Manager', 75000, 3, 0018),
('Product Manager', 70000, 3, 0019),
('Product Specialist', 70000, 3, 0020),
('Product Engineer', 90000, 3, 0021),

// Role Table for Sales
('Sales Manager', 110000, 4, 0022),
('Sales Associate', 60000, 4, 0024),
('Sales Specialist', 70000, 4, 0025),

// Role Table for Finance
('Finance Manager', 120000, 5, 0026),
('Finance Specialist', 80000, 5, 0027),
('Finance Analyst', 70000, 5, 0028),
('Finance Associate', 60000, 5, 0029),
('Finance Assistant', 50000, 5, 0030),

// Role Table for Legal
('Legal Manager', 120000, 6, 0031),
('Legal Specialist', 80000, 6, 0032), 
('Legal Associate', 60000, 6, 0033),
('Legal Assistant', 50000, 6, 0034),
('Lawyer', 100000, 6, 0035),

INSERT INTO employees (first_name, last_name, role_id, manager_id, employee_id) VALUES 
// Insert initial data for Human Resources
('Jason', 'Brooks', (SELECT id FROM roles WHERE name = 'HR Manager'), NULL, NULL),
('Jill', 'Anderson', (SELECT id FROM roles WHERE name = 'HR Specialist'), 1, NULL),
('Jenny', 'Gump', (SELECT id FROM roles WHERE name = 'HR Assistant'), 1, NULL),

('Jared', 'Carter', (SELECT id FROM roles WHERE name = 'Engineering Manager'), NULL, NULL),
('Jessica', 'Rodriquez', (SELECT id FROM roles WHERE name = 'Engineering Supervisor'), 2, NULL),
('Jasmine', 'Bimbo', (SELECT id FROM roles WHERE name = 'Engineering Supervisor'), 2, NULL),
('Alice', 'Ramos', (SELECT id FROM roles WHERE name = 'Software Engineer'), 2, NULL),
('Daniel', 'Capella', (SELECT id FROM roles WHERE name = 'Software Engineer'), 2, NULL),
('Jolene', 'Brown', (SELECT id FROM roles WHERE name = 'Software Engineer'), 2, NULL),
('Sarah', 'Brooks', (SELECT id FROM roles WHERE name = ' Junior Software Engineer'), 2, NULL),
('Fredrick', 'Hampton', (SELECT id FROM roles WHERE name = 'Junior Software Engineer'), 2, NULL),

('Annabella', 'Milan', (SELECT id FROM roles WHERE name = ' Senior Product Manager'), 3, NULL),
('Jay', 'Elliott', (SELECT id FROM roles WHERE name = 'Product Supervisor'), 3, NULL),
('Ronald', 'McKay', (SELECT id FROM roles WHERE name = 'Product Engineer'), 3, NULL),
('Rosemary', 'Proctor', (SELECT id FROM roles WHERE name = 'Product Engineer'), 3, NULL),
('Jon', 'Brooks', (SELECT id FROM roles WHERE name = 'Product Engineer'), 3, NULL),
('John', 'Foster', (SELECT id FROM roles WHERE name = 'Product Engineer'), 3, NULL),
('Arya', 'Proctor', (SELECT id FROM roles WHERE name = 'Product Analyst'), 3, NULL),
('Courtney', 'Gilroy', (SELECT id FROM roles WHERE name = 'Product Analyst'), 3, NULL),
('Roger', 'Sanders', (SELECT id FROM roles WHERE name = 'Product Specialist'), 3, NULL),
('Christopher', 'Ramirez', (SELECT id FROM roles WHERE name = 'Product Specialist'), 3, NULL),

('Jimmy', 'Brown', (SELECT id FROM roles WHERE name = 'Sales Manager'), NULL, NULL),
('Scott', 'Monroe', (SELECT id FROM roles WHERE name = 'Sales Associate'), 4, NULL),
('Robert', 'Franklin', (SELECT id FROM roles WHERE name = 'Sales Specialist'), 4, NULL),

('Charlie', 'Murphy', (SELECT id FROM roles WHERE name = 'Finance Manager'), NULL, NULL),
('Arnold', 'Fitzpatrick', (SELECT id FROM roles WHERE name = 'Finance Specialist'), 5, NULL),
('Shawn', 'Burnett', (SELECT id FROM roles WHERE name = 'Finance Analyst'), 5, NULL),
('Richard', 'Morris', (SELECT id FROM roles WHERE name = 'Finance Associate'), 5, NULL),
('Benjamin', 'Gordon', (SELECT id FROM roles WHERE name = 'Finance Assistant'), 5, NULL),

('Jim', 'Carey', (SELECT id FROM roles WHERE name = 'Legal Manager'), NULL, NULL),
('Courtney', 'Gilroy', (SELECT id FROM roles WHERE name = 'Legal Lawyer'), 6, NULL),
('Rosemary', 'Proctor', (SELECT id FROM roles WHERE name = 'Legal Specialist'), 6, NULL),
('Jon', 'Brooks', (SELECT id FROM roles WHERE name = 'Legal Analyst'), 6, NULL),
('John', 'Foster', (SELECT id FROM roles WHERE name = 'Legal Associate'), 6, NULL),
('Arya', 'Proctor', (SELECT id FROM roles WHERE name = 'Legal Assistant'), 6, NULL),

export default seedData;



