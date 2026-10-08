-- Recipe Sharing Platform - database schema
-- Run:  mysql -u root -p < database/schema.sql
CREATE DATABASE IF NOT EXISTS recipe_db;
USE recipe_db;

CREATE TABLE IF NOT EXISTS users (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(64)  NOT NULL,
    role          ENUM('ADMIN','USER') NOT NULL DEFAULT 'USER',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS recipes (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT NOT NULL,
    title        VARCHAR(200) NOT NULL,
    description  TEXT,
    ingredients  TEXT NOT NULL,
    instructions TEXT NOT NULL,
    category     VARCHAR(50),
    image_path   VARCHAR(255),
    prep_time    INT NOT NULL DEFAULT 30,
    servings     INT NOT NULL DEFAULT 2,
    difficulty   ENUM('EASY','MEDIUM','HARD') NOT NULL DEFAULT 'EASY',
    status       ENUM('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ratings (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    user_id   INT NOT NULL,
    stars     TINYINT NOT NULL CHECK (stars BETWEEN 1 AND 5),
    UNIQUE (recipe_id, user_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id)   REFERENCES users(id)   ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comments (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id  INT NOT NULL,
    user_id    INT NOT NULL,
    content    TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id)   REFERENCES users(id)   ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS system_settings (
    setting_key   VARCHAR(100) PRIMARY KEY,
    setting_value VARCHAR(255) NOT NULL
);

-- Starter data: default admin (email: admin@recipe.com, password: admin123)
INSERT IGNORE INTO users (name, email, password_hash, role)
VALUES ('Admin', 'admin@recipe.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN');

INSERT IGNORE INTO system_settings (setting_key, setting_value)
VALUES ('site_name', 'Recipe Sharing Platform'),
       ('recipes_need_approval', 'true');
