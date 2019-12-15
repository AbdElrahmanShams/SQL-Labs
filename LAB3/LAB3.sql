-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SAMPLE40
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SAMPLE40
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SAMPLE40` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
SHOW WARNINGS;
USE `SAMPLE40` ;

-- -----------------------------------------------------
-- Table `SAMPLE40`.`publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE40`.`publisher` (
  `Name` VARCHAR(20) NOT NULL,
  `Address` VARCHAR(40) NOT NULL,
  `Phone` CHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `SAMPLE40`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE40`.`book` (
  `BookId` CHAR(20) NOT NULL,
  `Title` VARCHAR(30) NOT NULL,
  `PublisherName` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`BookId`),
  INDEX `PublisherName` (`PublisherName` ASC) VISIBLE,
  CONSTRAINT `book_ibfk_1`
    FOREIGN KEY (`PublisherName`)
    REFERENCES `SAMPLE40`.`publisher` (`Name`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `SAMPLE40`.`book_authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE40`.`book_authors` (
  `BookId` CHAR(20) NOT NULL,
  `AuthorName` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`BookId`, `AuthorName`),
  CONSTRAINT `book_authors_ibfk_1`
    FOREIGN KEY (`BookId`)
    REFERENCES `SAMPLE40`.`book` (`BookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `SAMPLE40`.`library_branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE40`.`library_branch` (
  `BranchId` INT(11) NOT NULL,
  `BranchName` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`BranchId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `SAMPLE40`.`book_copies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE40`.`book_copies` (
  `BookId` CHAR(20) NOT NULL,
  `BranchId` INT(11) NOT NULL,
  `No_Of_Copies` INT(11) NOT NULL,
  PRIMARY KEY (`BookId`, `BranchId`),
  INDEX `BranchId` (`BranchId` ASC) VISIBLE,
  CONSTRAINT `book_copies_ibfk_1`
    FOREIGN KEY (`BookId`)
    REFERENCES `SAMPLE40`.`book` (`BookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `book_copies_ibfk_2`
    FOREIGN KEY (`BranchId`)
    REFERENCES `SAMPLE40`.`library_branch` (`BranchId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `SAMPLE40`.`borrower`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE40`.`borrower` (
  `CardNo` INT(11) NOT NULL,
  `Name` VARCHAR(30) NOT NULL,
  `Address` VARCHAR(40) NOT NULL,
  `Phone` CHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`CardNo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `SAMPLE40`.`book_loans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAMPLE40`.`book_loans` (
  `CardNo` INT(11) NOT NULL,
  `BookId` CHAR(20) NOT NULL,
  `BranchId` INT(11) NOT NULL,
  `DateOut` DATE NOT NULL,
  `DueDate` DATE NOT NULL,
  PRIMARY KEY (`CardNo`, `BookId`, `BranchId`),
  INDEX `BranchId` (`BranchId` ASC) VISIBLE,
  INDEX `BookId` (`BookId` ASC) VISIBLE,
  CONSTRAINT `book_loans_ibfk_1`
    FOREIGN KEY (`CardNo`)
    REFERENCES `SAMPLE40`.`borrower` (`CardNo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `book_loans_ibfk_2`
    FOREIGN KEY (`BranchId`)
    REFERENCES `SAMPLE40`.`library_branch` (`BranchId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `book_loans_ibfk_3`
    FOREIGN KEY (`BookId`)
    REFERENCES `SAMPLE40`.`book` (`BookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
