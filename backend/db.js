// Підключення до бази даних MySQL
require('dotenv').config();
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    port: Number(process.env.DB_PORT) || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'db',
    waitForConnections: true,
    connectionLimit: 10,
    charset: 'utf8mb4'
});

// Перевірка підключення
async function testConnection() {
    try {
        const connection = await pool.getConnection();
        console.log('Успішне підключення до бази даних!');
        connection.release();
        return true;
    } catch (err) {
        console.error('Помилка підключення до бази даних:', err.message);
        return false;
    }
}

module.exports = { pool, testConnection };
