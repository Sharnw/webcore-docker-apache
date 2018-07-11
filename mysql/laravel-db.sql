CREATE DATABASE `laravel-db`;

USE `laravel-db`;

CREATE USER 'laravel-user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'laravel-pass';
GRANT ALL PRIVILEGES ON *.* TO 'laravel-user'@'localhost' WITH GRANT OPTION;
CREATE USER 'laravel-user'@'%' IDENTIFIED WITH mysql_native_password BY 'laravel-pass';
GRANT ALL PRIVILEGES ON *.* TO 'laravel-user'@'%' WITH GRANT OPTION;

CREATE DATABASE IF NOT EXISTS `laravel-db` COLLATE 'utf8_general_ci' ;
GRANT ALL ON `laravel-db`.* TO 'laravel-user'@'%' ;

FLUSH PRIVILEGES ;