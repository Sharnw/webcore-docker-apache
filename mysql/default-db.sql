CREATE DATABASE `laravel-db`;

USE `laravel-db`;

CREATE USER `laravel-user`;

GRANT ALL PRIVILEGES on `laravel`.* TO `laravel-user`@'%' IDENTIFIED BY 'laravel-pass' WITH GRANT OPTION;
UPDATE mysql.user SET Super_Priv='Y' WHERE user='laravel-user' AND host='%';

FLUSH PRIVILEGES;