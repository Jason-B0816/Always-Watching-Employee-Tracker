DROP DATABASE IF EXISTS employee_db;
CREATE DATABASE employee_db;

\c employee_db;

-- Creating Departments Table
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL
);

-- Creating Roles Table
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(30) UNIQUE NOT NULL, 
    salary DECIMAL NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments (id) ON DELETE CASCADE
 CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE CASCADE,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employees (id) ON DELETE SET NULL
);

-- Creating Employees Table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    role_id INT NOT NULL,
    manager_id INT,
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE CASCADE,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employees (id) ON DELETE SET NULL
);
-- Adding Unique Constraints
ALTER TABLE employees ADD CONSTRAINT unique_employee UNIQUE (first_name, last_name);
ALTER TABLE roles ADD CONSTRAINT unique_role UNIQUE (title, department_id);
-- Adding Indexes
CREATE INDEX idx_department_name ON departments (name);
CREATE INDEX idx_role_title ON roles (title);
CREATE INDEX idx_employee_name ON employees (first_name, last_name);
-- Adding Check Constraints
ALTER TABLE roles ADD CONSTRAINT check_salary CHECK (salary > 0);
ALTER TABLE employees ADD CONSTRAINT check_name CHECK (first_name <> '' AND last_name <> '');
-- Adding Default Values
ALTER TABLE employees ALTER COLUMN manager_id SET DEFAULT NULL;
ALTER TABLE roles ALTER COLUMN salary SET DEFAULT 0;