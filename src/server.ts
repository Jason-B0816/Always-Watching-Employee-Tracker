import express from 'express';
import inquirer from 'inquirer';
import { pool } from './connection.js';
import { connectToDb } from './connection.js';
// import seeds.sql from './seeds.sql';
// import schema.sql from './schema.sql';

await connectToDb();

const PORT = process.env.PORT || 3001;
const app = express();

// Express middleware
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

// Inquirer menu and logic for CRUD operations on the database
const viewAllDepartments = async () => {
const result = await pool.query('SELECT * FROM department');
console.table(result.rows);
};

const viewAllRoles = async () => {
    const result = await pool.query('SELECT * FROM role');
    console.table(result.rows);
};

const viewAllEmployees = async () => {
    const result = await pool.query('SELECT * FROM employee');
    console.table(result.rows);
};

const mainMenu = async () => {
  const answers = await inquirer.prompt([
    {
      type: 'list',
      name: 'action',
      message: 'What would you like to do?',
    choices: [
        'View all departments',
        'View all roles',
        'View all employees',
        'Add a department',
        'Add a role',
        'Add an employee',
        'Update an employee role',
        'Update employee manager',
        'View employees by manager',
        'View employees by department',
        'Delete a department, role, or employee',
        'View the total utilized budget of a department',
        'Exit'
    ],
    },
  ]);

  switch (answers.action) {
    case 'View all departments':
        await viewAllDepartments();
        break;
    case 'View all roles':
        await viewAllRoles();
        break;
    case 'View all employees':
        await viewAllEmployees();
        break;
    case 'Add a department':
    await addDepartment();
    break;
    case 'Add a role':
    await addRole();
    break;
    case 'Add an employee':
    await addEmployee();
    break;
    case 'Update an employee role':
    await updateEmployeeRole();
    break;
    case 'Update employee manager':
    await updateEmployeeManager();  
    break;
    case 'View employees by manager':
    await viewEmployeesByManager();
    break;
    case 'View employees by department':
    await viewEmployeesByDepartment();
    break;
    case 'Delete a department, role, or employee':
    await deleteDepartmentRoleEmployee();
    break;
    case 'View the total utilized budget of a department':
    await viewBudget();
    break;
    case 'Exit':
    process.exit();
    break;
    default:
    console.log('Invalid action:', answers.action);
    process.exit(1);
    }
    }
    mainMenu();


const addDepartment = async () => {
    const answers = await inquirer.prompt([
        {
            type: 'input',
            name: 'name',
            message: 'What is the name of the department?',
        },
    ]);

    await pool.query('INSERT INTO department (name) VALUES ($1)', [answers.name]);
    console.log(`Added department ${answers.name}.`);
};

const addRole = async () => {
    const departments = await pool.query('SELECT * FROM department');
    const answers = await inquirer.prompt([
        {
            type: 'input',
            name: 'title',
            message: 'What is the title of the role?',
        },
        {
            type: 'input',
            name: 'salary',
            message: 'What is the salary of the role?',
        },
        {
            type: 'list',
            name: 'department_id',
            message: 'Which department does the role belong to?',
            choices: departments.rows.map((department) => ({
                name: department.name,

                value: department.id,
            })),
        },
    ]);

    await pool.query('INSERT INTO role (title, salary, department_id) VALUES ($1, $2, $3)', [answers.title, answers.salary, answers.department_id]);
    console.log(`Added role ${answers.title}.`);
};

mainMenu();

const addEmployee = async () => {
    const roles = await pool.query('SELECT * FROM role');
    const employees = await pool.query('SELECT * FROM employee');
    const answers = await inquirer.prompt([
        {
            type: 'input',
            name: 'first_name',
            message: "What is the employee's first name?",
        },
        {
            type: 'input',
            name: 'last_name',
            message: "What is the employee's last name?",
        },
        {
            type: 'list',
            name: 'role_id',
            message: "What is the employee's role?",
            choices: roles.rows.map((role) => ({
                name: role.title,
                value: role.id,
            })),
        },
        {
            type: 'list',
            name: 'manager_id',
            message: "Who is the employee's manager?",
            choices: employees.rows.map((employee) => ({
                name: `${employee.first_name} ${employee.last_name}`,
                value: employee.id,
            })),
        },
    ]);

    const managerId = (await pool.query('SELECT id FROM employee WHERE first_name = $1 AND last_name = $2', [answers.manager.split(' ')[0], answers.manager.split(' ')[1]]))?.rows[0]?.id;
   
    await pool.query('INSERT INTO employee (first_name, last_name, role_id, manager_id) VALUES ($1, $2, $3, $4)', [answers.first_name, answers.last_name, answers.role_id, managerId]);
    console.log(`Added employee ${answers.first_name} ${answers.last_name}.`);
};

const updateEmployeeRole = async () => {
    const employees = await pool.query('SELECT * FROM employee');
    const roles = await pool.query('SELECT * FROM role');
    const answers = await inquirer.prompt([
        {
            type: 'list',
            name: 'employee',
            message: 'Which employee would you like to update?',
            choices: employees.rows.map((employee) => ({
                name: `${employee.first_name} ${employee.last_name}`,
                value: employee.id,
            })),
        },
        {
            type: 'list',
            name: 'role',
            message: 'What is the employee\'s new role?',
            choices: roles.rows.map((role) => ({
                name: role.title,
                value: role.id,
            })),
        },
    ]);

    await pool.query('UPDATE employee SET role_id = $1 WHERE id = $2', [answers.role, answers.employee]);
    console.log(`Updated employee's role.`);
};

const updateEmployeeManager = async () => {
    const employees = await pool.query('SELECT * FROM employee');
    const answers = await inquirer.prompt([
        {
            type: 'list',
            name: 'employee',
            message: 'Which employee would you like to update?',
            choices: employees.rows.map((employee) => ({
                name: `${employee.first_name} ${employee.last_name}`,
                value: employee.id,
            })),
        },
        {
            type: 'list',
            name: 'manager',
            message: 'Who is the employee\'s new manager?',
            choices: employees.rows.map((employee) => ({
                name: `${employee.first_name} ${employee.last_name}`,
                value: employee.id,
            })),
        },
    ]);

    const employeeId = (await pool.query<{ id: number }>('SELECT id FROM employee WHERE first_name = $1 AND last_name = $2', [answers.employee.split(' ')[0], answers.employee.split(' ')[1]])).rows[0].id;
    const managerId = (await pool.query('SELECT id FROM employee WHERE first_name = $1 AND last_name = $2', [answers.manager.split(' ')[0], answers.manager.split(' ')[1]])).rows[0].id;
    
    await pool.query('UPDATE employee SET manager_id = $1 WHERE id = $2', [answers.manager, answers.employee]);
    console.log(`Updated employee's manager.`);
};

const viewEmployeesByManager = async () => {
    const employees = await pool.query('SELECT * FROM employee');
    const answers = await inquirer.prompt([
        {
            type: 'list',
            name: 'manager',
            message: 'Which manager\'s employees would you like to view?',
            choices: employees.rows.map((employee) => ({    
                name: `${employee.first_name} ${employee.last_name}`,
                value: employee.id,
            })),
        },
    ]);

    const managerId = (await pool.query('SELECT id FROM employee WHERE first_name = $1 AND last_name = $2', [answers.manager.split(' ')[0], answers.manager.split(' ')[1]])).rows[0].id;
    const result = await pool.query('SELECT * FROM employee WHERE manager_id = $1', [answers.manager]);
    console.table(result.rows);
};

const viewEmployeesByDepartment = async () => {
    const departments = await pool.query('SELECT * FROM department');
    const answers = await inquirer.prompt([
        {
            type: 'list',
            name: 'department',
            message: 'Which department\'s employees would you like to view?',
            choices: departments.rows.map((department) => ({
                name: department.name,
                value: department.id,
            })),
        },
    ]);

    const result = await pool.query('SELECT * FROM employee WHERE role_id IN (SELECT id FROM role WHERE department_id = $1)', [answers.department]);
    console.table(result.rows);
}

const deleteDepartmentRoleEmployee = async () => {
    const departments = await pool.query('SELECT * FROM department');
    const roles = await pool.query('SELECT * FROM role');
    const employees = await pool.query('SELECT * FROM employee');
    const answers = await inquirer.prompt([
        {
            type: 'list',
            name: 'action',
            message: 'What would you like to delete?',
            choices: ['Department', 'Role', 'Employee'],
        },
    ]);

    switch (answers.action) {
        case 'Department':
            const department = await inquirer.prompt([
                {
                    type: 'list',
                    name: 'department',
                    message: 'Which department would you like to delete?',
                    choices: departments.rows.map((department) => ({
                        name: department.name,
                        value: department.id,
                    })),
                },
            ]);
            await pool.query('DELETE FROM department WHERE id = $1', [department.department]);
            console.log('Deleted department.');
            break;
        case 'Role':
            const role = await inquirer.prompt([
                {
                    type: 'list',
                    name: 'role',
                    message: 'Which role would you like to delete?',
                    choices: roles.rows.map((role) => ({
                        name: role.title,
                        value: role.id,
                    })),
                },
            ]);
            await pool.query('DELETE FROM role WHERE id = $1', [role.role]);
            console.log('Deleted role.');
            break;
        case 'Employee':
            const employee = await inquirer.prompt([
                {
                    type: 'list',
                    name: 'employee',
                    message: 'Which employee would you like to delete?',
                    choices: employees.rows.map((employee) => ({
                        name: `${employee.first_name} ${employee.last_name}`,
                        value: employee.id,
                    })),
                },
            ]);
            await pool.query('DELETE FROM employee WHERE id = $1', [employee.employee]);
            console.log('Deleted employee.');
            break;
        default:
            console.log('Invalid action:', answers.action);
            process.exit(1);
    }
};

const viewBudget = async () => {
    const departments = await pool.query('SELECT * FROM department');
    const answers = await inquirer.prompt([
        {
            type: 'list',
            name: 'department',
            message: 'Which department\'s budget would you like to view?',
            choices: departments.rows.map((department) => ({
                name: department.name,
                value: department.id,
            })),
        },
    ]);

    const result = await pool.query('SELECT SUM(salary) FROM role WHERE department_id = $1', [answers.department]);
    console.table(result.rows);
};

export { viewAllDepartments, viewAllRoles, viewAllEmployees, addDepartment, addRole, addEmployee, updateEmployeeRole, updateEmployeeManager, viewEmployeesByManager, viewEmployeesByDepartment, deleteDepartmentRoleEmployee, viewBudget };

// Start the application
mainMenu().then(() => {
    console.log('Operation complete.');
    process.exit();
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
}); 

export default pool;



