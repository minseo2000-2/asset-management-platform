-- Minseo Asset Management Database Initialization

-- Create user
CREATE USER IF NOT EXISTS 'minseo_user'@'%' IDENTIFIED BY 'minseo_pass123';
GRANT ALL PRIVILEGES ON minseo_asset.* TO 'minseo_user'@'%';
FLUSH PRIVILEGES;
