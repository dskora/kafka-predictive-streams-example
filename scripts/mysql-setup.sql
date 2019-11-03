GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replicator' IDENTIFIED BY 'replpass';
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT  ON *.* TO 'debezium' IDENTIFIED BY 'dbz';

# Create the database that we'll use to populate data and watch the effect in the binlog
CREATE DATABASE demo;
GRANT ALL PRIVILEGES ON demo.* TO 'mysqluser'@'%';

use demo;

CREATE TABLE `mdl_user` (
    `userid` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`userid`)
);

CREATE TABLE `mdl_logstore_standard_log` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `eventname` VARCHAR(255) NOT NULL,
    `userid` INT NOT NULL,
    `timecreated` BIGINT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `intakes` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `release_date` DATE NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `courses` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `student_courses` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `student_id` INT NOT NULL,
    `stunumber` VARCHAR(255),
    `course_id` INT NOT NULL,
    `intake_id` INT NOT NULL,
    `status` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `student_course_withdrawals` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `student_course_id` INT NOT NULL,
    `withdrawn_date` DATETIME,
    PRIMARY KEY (`id`)
);
