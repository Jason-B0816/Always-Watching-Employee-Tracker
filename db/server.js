import express from 'express';
import inquirer from 'inquirer';
import { pool } from './connection.js';
import { connectToDb } from './connection.js';

await connectToDb();

const PORT = process.env.PORT || 3001;
const app = express();
// Express middleware
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

// Create a new employee
app.post('/api/employees', async (req, res) => {
    const sql = `INSERT INTO employee (employee_name)
    VALUES ($1)`;
    const params = [body.employee_name];
    pool.query(sql, params, (err, _result) => {
        if (err) {
            res.status(400).json({ error: err.message });
            return;
        }
        res.json({
            message: 'success',
            data: body,
        });
    });
});

// Read all employees
app.get('/api/employees', async (req, res) => {
    try {
        const { rows } = await pool.query('SELECT * FROM employees');
        res.json(rows);
    }
    catch (err) {
        console.error('Error getting employees:', err);
        res.status(500).json({ error: 'Error getting employees' });
    }
}
);

// Update an employee
app.put('/api/employee/:id', (req, res) => {
    const sql = `UPDATE employee SET employee = $1 WHERE id = $2`;
    const params = [req.body.employee_name, req.params.id];
    pool.query(sql, params, (err, result) => {
        if (err) {
            res.status(400).json({ error: err.message });
        }
        else if (!result.rowCount) {
            res.json({
                message: 'Review not found',
            });
        }
        else {
            res.json({
                message: 'success',
                data: req.body,
                changes: result.rowCount,
            });
        }
    });
});

// Delete an employee
app.delete('/api/employees/:id', async (req, res) => {
    const sql = 'DELETE FROM employees WHERE id = $1';
    const params = [req.params.id];
    pool.query(sql, params, (err, result) => {
        if (err) {
            res.status(400).json({ error: err.message });
        }
        else if (!result.rowCount) {
            res.json({
                message: 'Employee not found',
            });
        }
        else {
            res.json({
                message: 'deleted',
                changes: result.rowCount,
                id: req.params.id,
            });
        }
    });
});

// Default response for any other request (Not Found)
app.use((_req, res) => {
    res.status(404).end();
});
app.listen(PORT, () => {
    Console.log(`server running on port ${PORT}`);
});
