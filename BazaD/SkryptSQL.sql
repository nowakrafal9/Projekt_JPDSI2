-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblioteka_JPDSI2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteka_JPDSI2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteka_JPDSI2` DEFAULT CHARACTER SET utf8 ;
USE `biblioteka_JPDSI2` ;

-- -----------------------------------------------------
-- Table `biblioteka_JPDSI2`.`author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka_JPDSI2`.`author` (
  `idAuthor` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idAuthor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteka_JPDSI2`.`publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka_JPDSI2`.`publisher` (
  `idPublisher` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPublisher`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteka_JPDSI2`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka_JPDSI2`.`genre` (
  `idGenre` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteka_JPDSI2`.`bookInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka_JPDSI2`.`bookInfo` (
  `idTitle` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(60) NOT NULL,
  `idAuthor` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `idGenre` INT NOT NULL,
  `pages` INT NOT NULL,
  `idPublisher` INT NOT NULL,
  PRIMARY KEY (`idTitle`),
  INDEX `fk_bookInfo_author_idx` (`idAuthor` ASC),
  INDEX `fk_bookInfo_publisher1_idx` (`idPublisher` ASC),
  INDEX `fk_bookInfo_genre1_idx` (`idGenre` ASC),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  CONSTRAINT `fk_bookInfo_author`
    FOREIGN KEY (`idAuthor`)
    REFERENCES `biblioteka_JPDSI2`.`author` (`idAuthor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookInfo_publisher1`
    FOREIGN KEY (`idPublisher`)
    REFERENCES `biblioteka_JPDSI2`.`publisher` (`idPublisher`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookInfo_genre1`
    FOREIGN KEY (`idGenre`)
    REFERENCES `biblioteka_JPDSI2`.`genre` (`idGenre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteka_JPDSI2`.`borrower`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka_JPDSI2`.`borrower` (
  `idBorrower` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `postalCode` VARCHAR(6) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `phoneNum` VARCHAR(13) NOT NULL,
  `email` VARCHAR(50) NULL,
  `status` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idBorrower`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteka_JPDSI2`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka_JPDSI2`.`role` (
  `idRole` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRole`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteka_JPDSI2`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka_JPDSI2`.`employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `idRole` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `status` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idEmployee`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  INDEX `fk_employee_role1_idx` (`idRole` ASC),
  CONSTRAINT `fk_employee_role1`
    FOREIGN KEY (`idRole`)
    REFERENCES `biblioteka_JPDSI2`.`role` (`idRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteka_JPDSI2`.`bookStock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka_JPDSI2`.`bookStock` (
  `idBook` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(10) NOT NULL,
  `idTitle` INT NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `idEmployee` INT NOT NULL,
  PRIMARY KEY (`idBook`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_bookStock_employee1_idx` (`idEmployee` ASC),
  INDEX `fk_bookStock_bookInfo1_idx` (`idTitle` ASC),
  CONSTRAINT `fk_bookStock_employee1`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `biblioteka_JPDSI2`.`employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookStock_bookInfo1`
    FOREIGN KEY (`idTitle`)
    REFERENCES `biblioteka_JPDSI2`.`bookInfo` (`idTitle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteka_JPDSI2`.`borrowed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteka_JPDSI2`.`borrowed` (
  `idBorrowed` INT NOT NULL AUTO_INCREMENT,
  `idBook` INT NOT NULL,
  `idBorrower` INT NOT NULL,
  `idEmployee` INT NOT NULL,
  `borrowDate` DATE NOT NULL,
  `returnDue` DATE NOT NULL,
  `returnDate` DATE NULL,
  `status` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idBorrowed`),
  INDEX `fk_borrowed_bookStock1_idx` (`idBook` ASC),
  INDEX `fk_borrowed_borrower1_idx` (`idBorrower` ASC),
  INDEX `fk_borrowed_employee1_idx` (`idEmployee` ASC),
  CONSTRAINT `fk_borrowed_bookStock1`
    FOREIGN KEY (`idBook`)
    REFERENCES `biblioteka_JPDSI2`.`bookStock` (`idBook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_borrowed_borrower1`
    FOREIGN KEY (`idBorrower`)
    REFERENCES `biblioteka_JPDSI2`.`borrower` (`idBorrower`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_borrowed_employee1`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `biblioteka_JPDSI2`.`employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
