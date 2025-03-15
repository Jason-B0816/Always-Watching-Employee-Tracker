DROP DATABASE IF EXISTS employee_db;
CREATE DATABASE employee_db;

\c employee_db;

-- Create the necessary tables
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL
);

-- Create the roles table
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(30) UNIQUE NOT NULL,
    salary DECIMAL NOT NULL,
    department_id INT REFERENCES departments(id) ON DELETE SET NULL -- Change to NULL if the department is deleted
);

-- Create the employees table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    salary DECIMAL NOT NULL,
    role_id INT REFERENCES roles(id) ON DELETE SET NULL,  -- Set role to NULL if the role is deleted
    manager_id INT REFERENCES employees(id) ON DELETE SET NULL, -- Set manager to NULL if the manager is deleted
    employee_id INT REFERENCES employees(id) ON DELETE SET NULL  -- Set employee to NULL if the employee is deleted
);

