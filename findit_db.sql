-- Create and use the database
CREATE DATABASE IF NOT EXISTS findit_db;
USE findit_db;
-- =====================================================================
-- TABLE: categories
-- =====================================================================
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- =====================================================================
-- TABLE: users
-- =====================================================================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'USER') DEFAULT 'USER',
    status ENUM('active', 'pending', 'suspended') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- =====================================================================
-- TABLE: items
-- =====================================================================
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    category_id INT,
    type ENUM('LOST', 'FOUND') NOT NULL,
    location VARCHAR(200),
    date_occurred DATE,
    contact_preference ENUM('email', 'phone', 'both') DEFAULT 'email',
    status ENUM('active', 'resolved', 'removed') DEFAULT 'active',
    matched_lost_item_id INT DEFAULT NULL,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE
    SET NULL,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (matched_lost_item_id) REFERENCES items(id) ON DELETE
    SET NULL
);
-- =====================================================================
-- TABLE: notifications
-- =====================================================================
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    from_user_id INT,
    item_id INT,
    matched_item_id INT,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (from_user_id) REFERENCES users(id) ON DELETE
    SET NULL,
        FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE,
        FOREIGN KEY (matched_item_id) REFERENCES items(id) ON DELETE
    SET NULL
);
-- =====================================================================
-- TABLE: messages
-- =====================================================================
CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message_text TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);
-- =====================================================================
-- TABLE: claims
-- =====================================================================
CREATE TABLE claims (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    claimer_id INT,
    message TEXT,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE,
    FOREIGN KEY (claimer_id) REFERENCES users(id) ON DELETE CASCADE
);
-- =====================================================================
-- SEED DATA
-- =====================================================================
INSERT INTO categories (name)
VALUES ('Electronics'),
    ('Clothing'),
    ('Bags & Wallets'),
    ('Keys'),
    ('Documents'),
    ('Jewellery'),
    ('Books'),
    ('Other');
INSERT INTO users (
        full_name,
        email,
        phone,
        password_hash,
        role,
        status
    )
VALUES (
        'System Admin',
        'admin@findit.com',
        '0000000000',
        'e86f78a8a3caf0b60d8e74e5942aa6d86dc150cd3c03338aef25b7d2d7e3acc7',
        'ADMIN',
        'active'
    );