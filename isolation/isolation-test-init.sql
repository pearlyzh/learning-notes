DROP PROCEDURE IF EXISTS generate_schema;

CREATE SCHEMA `test_isolation` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `test_isolation`;

DELIMITER $$
CREATE PROCEDURE generate_schema()
BEGIN
    DROP TABLE IF EXISTS `foo`;
    DROP TABLE IF EXISTS `bar`;

    CREATE TABLE `foo`
    (
        `id`   INT          NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(255) NOT NULL,
        `year` INT          NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB;

    CREATE TABLE `bar`
    (
        `id`   INT          NOT NULL AUTO_INCREMENT,
        `name` VARCHAR(255) NOT NULL,
        `year` INT          NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB;

    INSERT INTO `foo` (id, name, year) VALUES (1, "stack", 1993);
    INSERT INTO `foo` (id, name, year) VALUES (2, "over", 1994);
    INSERT INTO `foo` (id, name, year) VALUES (3, "flow", 1995);
    INSERT INTO `bar` (id, name, year) VALUES (2, "xyz", 2019);

END$$
DELIMITER ;

CALL generate_schema();

