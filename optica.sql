-- MySQL Script generated by MySQL Workbench
-- Mon Nov 20 09:15:25 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`adresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`adresses` (
  `idAdress` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `number` INT NULL,
  `floor` INT NULL,
  `door` INT NULL,
  `cp` INT NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdress`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`brand` (
  `idBrand` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idBrand`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`provider` (
  `idProvider` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone number` INT NOT NULL,
  `fax` INT NULL,
  `adress_id` INT NULL,
  `brands_id` INT NOT NULL,
  PRIMARY KEY (`idProvider`),
  INDEX `brands_id_idx` (`brands_id` ASC) VISIBLE,
  CONSTRAINT `adress_id`
    FOREIGN KEY (`idProvider`)
    REFERENCES `optica`.`adresses` (`idAdress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `brands_id`
    FOREIGN KEY (`brands_id`)
    REFERENCES `optica`.`brand` (`idBrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmployee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`client` (
  `idClients` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `cp` INT NOT NULL,
  `phoneNumber` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `regDate` DATE NOT NULL,
  `recomendedBy` INT NULL,
  `sellBy` INT NOT NULL,
  `client_idClients` INT NOT NULL,
  PRIMARY KEY (`idClients`, `client_idClients`),
  INDEX `sellBy_idx` (`sellBy` ASC) VISIBLE,
  INDEX `fk_client_client1_idx` (`recomendedBy` ASC) VISIBLE,
  CONSTRAINT `sellBy`
    FOREIGN KEY (`sellBy`)
    REFERENCES `optica`.`employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_client1`
    FOREIGN KEY (`recomendedBy`)
    REFERENCES `optica`.`client` (`idClients`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`glasses` (
  `idGlasses` INT NOT NULL AUTO_INCREMENT,
  `brand_id` INT NOT NULL,
  `gradesLeft` FLOAT NOT NULL,
  `gradesRight` FLOAT NOT NULL,
  `mountingType` ENUM('flotante', 'pasta', 'metalica') NOT NULL,
  `colour` VARCHAR(20) NOT NULL,
  `glassColourLeft` VARCHAR(20) NOT NULL,
  `glassColourRight` VARCHAR(20) NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`idGlasses`),
  INDEX `brand_id_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `brand_id`
    FOREIGN KEY (`brand_id`)
    REFERENCES `optica`.`brand` (`idBrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`order` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  INDEX `id_user_idx` (`id_user` ASC) VISIBLE,
  PRIMARY KEY (`idOrder`),
  CONSTRAINT `id_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `optica`.`client` (`idClients`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`orderDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`orderDetail` (
  `id` INT NOT NULL,
  `order_idOrder` INT NOT NULL,
  `glasses_idGlasses` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_has_glasses_glasses1_idx` (`glasses_idGlasses` ASC) VISIBLE,
  INDEX `fk_order_has_glasses_order1_idx` (`order_idOrder` ASC) VISIBLE,
  CONSTRAINT `fk_order_has_glasses_order1`
    FOREIGN KEY (`order_idOrder`)
    REFERENCES `optica`.`order` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_has_glasses_glasses1`
    FOREIGN KEY (`glasses_idGlasses`)
    REFERENCES `optica`.`glasses` (`idGlasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
