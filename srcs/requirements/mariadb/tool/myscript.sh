mysql -u root -p;

CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';

GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost';
