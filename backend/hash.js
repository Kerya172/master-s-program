require('dotenv').config();
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const jwt = require('jsonwebtoken');
const { spawn } = require('child_process');
const { pool, testConnection } = require('./db');

const app = express();
const PORT = process.env.PORT || 3000;
const JWT_SECRET = process.env.JWT_SECRET || 'dev-secret-change-me';
const PYTHON_BIN = process.env.PYTHON_BIN || 'python3';

const COOKIE_NAME = 'token';
const IS_PROD = process.env.NODE_ENV === 'production';

const ALGORITHMS = ['md5', 'sha1', 'sha256', 'pbkdf2_sha256', 'bcrypt', 'argon2id'];
