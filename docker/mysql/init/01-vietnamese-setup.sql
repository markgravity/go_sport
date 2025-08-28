-- Vietnamese charset and collation setup for Go Sport database
-- This script runs automatically when MySQL container starts for the first time

-- Set Vietnamese timezone
SET time_zone = '+07:00';

-- Ensure UTF-8 support for Vietnamese characters
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create Go Sport database with Vietnamese charset support (if not exists)
CREATE DATABASE IF NOT EXISTS go_sport 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Use the database
USE go_sport;

-- Grant privileges to go_sport_user
GRANT ALL PRIVILEGES ON go_sport.* TO 'go_sport_user'@'%';

-- Create a test table to verify Vietnamese support
CREATE TABLE IF NOT EXISTS charset_test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vietnamese_text VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert test Vietnamese data
INSERT IGNORE INTO charset_test (vietnamese_text) VALUES 
('Xin chào! Chào mừng đến với Go Sport'),
('Đây là ứng dụng thể thao cho người Việt'),
('Hỗ trợ đầy đủ ký tự tiếng Việt: áàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵđ'),
('VIẾT HOA: ÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬÉÈẺẼẸÊẾỀỂỄỆÍÌỈĨỊÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÚÙỦŨỤƯỨỪỬỮỰÝỲỶỸỴĐ');

-- Show the test data to verify Vietnamese character support
SELECT 'Vietnamese charset test completed' as status, vietnamese_text FROM charset_test;

FLUSH PRIVILEGES;