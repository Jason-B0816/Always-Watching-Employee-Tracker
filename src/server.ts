import inquirer from "inquirer";
import { pool, connectToDb } from "./connection.js";

await connectToDb();

function mainMenu() {
  inquirer
    .prompt([
      {
        type: "list",
        name: "selectedChoice",
        message: "What would you like to do?",
        choices: [
          "View all employees",
          "View all departments",
          "View all roles",
          "Add an employee",
          "Add a department",
          "Add a role",
          "Update an employee role",
          "Quit",
        ],
      },
    ])
    .then((answers) => {
      // Use user feedback for... whatever!!

      if (answers.selectedChoice === "View all departments") {
        // SELECT * FROM departments;
        pool.query("SELECT * FROM departments;").then((res) => {
          console.table(res.rows);
          mainMenu()
        });
      } else if (answers.selectedChoice === "View all roles") {
        pool.query("SELECT * FROM roles;").then((res) => {
          console.table(res.rows);
          mainMenu()
        });
      } else if (answers.selectedChoice === "View all employees") {
        pool.query("SELECT * FROM employees;").then((res) => {
          console.table(res.rows);
          mainMenu()
        });
      } else if (answers.selectedChoice === "Add an employee") {
        inquirer.prompt([
            {
                type: "input",
                name: "firstName",
                message: "What is the employee's first name?",
            },
            {
                type: "input",
                name: "lastName",
                message: "What is the employee's last name?",
            },
            {
                type: "input",
                name: "roleId",
                message: "What is the employee's role ID?",
            },
            {
                type: "input",
                name: "managerId",
                message: "What is the employee's manager ID?",
            }
        ])
        .then(answers => {
            pool.query("INSERT INTO employees (first_name, last_name, role_id, manager_id) VALUES ($1, $2, $3, $4)", [answers.firstName, answers.lastName, answers.roleId, answers.managerId])
            .then(() => {
                console.log("Employee added successfully");
                mainMenu();
            })
        })

      } else if (answers.selectedChoice === "Add a department") {
        inquirer.prompt([
            {
                type: "input",
                name: "departmentName",
                message: "What is the name of the department?",
            }
        ])
        .then(answers => {
            pool.query("INSERT INTO departments (name) VALUES ($1)", [answers.departmentName])
            .then(() => {
                console.log("Department added successfully");
                mainMenu();
            })
        })


      } else if (answers.selectedChoice === "Add a role") {
        inquirer.prompt([
            {
                type: "input",
                name: "title",
                message: "What is the title of the role?",
            },
            {
                type: "input",
                name: "salary",
                message: "What is the salary of the role?",
            },
            {
                type: "input",
                name: "departmentId",
                message: "What is the department ID of the role?",
            }
        ])
        .then(answers => {
            pool.query("INSERT INTO roles (title, salary, department_id) VALUES ($1, $2, $3)", [answers.title, answers.salary, answers.departmentId])
            .then(() => {
                console.log("Role added successfully");
                mainMenu();
            })
        })
      } else if (answers.selectedChoice === "Update an employee role") {
        inquirer.prompt([
            {
                type: "input",
                name: "employeeId",
                message: "What is the employee's ID?",
            },
            {
                type: "input",
                name: "roleId",
                message: "What is the new role ID?",
            }
        ])
        .then(answers => {
            pool.query("UPDATE employee SET role_id = $1 WHERE id = $2", [answers.roleId, answers.employeeId])
            .then(() => {
                console.log("Employee role updated successfully");
                mainMenu();
            })
        })

      } else if (answers.selectedChoice === "Quit") {
        pool.end();
      }
    });
}



mainMenu();