-- Схема бази даних ICEhash
-- Запуск: mysql -u root -p < db.sql

CREATE DATABASE IF NOT EXISTS db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE db;

-- Користувачі
CREATE TABLE IF NOT EXISTS users (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(32)  NOT NULL UNIQUE,
    email       VARCHAR(255) NOT NULL UNIQUE,
    is_admin    TINYINT(1)   NOT NULL DEFAULT 0,
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login  DATETIME     NULL
) ENGINE=InnoDB;

-- Хеші пароля: один рядок на кожен алгоритм.
-- algorithm: md5 | sha1 | sha256 | pbkdf2_sha256 | bcrypt | argon2id
CREATE TABLE IF NOT EXISTS password_hashes (
    user_id     INT UNSIGNED NOT NULL,
    algorithm   VARCHAR(32)  NOT NULL,
    hash        VARCHAR(255) NOT NULL,
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, algorithm),
    CONSTRAINT fk_hashes_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- Зробити користувача адміністратором (виконати вручну після реєстрації):
-- UPDATE users SET is_admin = 1 WHERE username = 'ваш_логін';
