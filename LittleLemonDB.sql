-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`CustomerDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`CustomerDetails` (
  `CustomerId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(150) NULL,
  PRIMARY KEY (`CustomerId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`StaffRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`StaffRoles` (
  `RoleId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RoleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`StaffInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`StaffInfo` (
  `StaffId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Full Name` VARCHAR(150) NOT NULL,
  `Salary` DECIMAL NOT NULL,
  `RoleId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`StaffId`),
  CONSTRAINT `StaffRole_FK`
    FOREIGN KEY (`RoleId`)
    REFERENCES `LittleLemonDB`.`StaffRoles` (`RoleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `StaffRole_FK_idx` ON `LittleLemonDB`.`StaffInfo` (`RoleId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `BookingDate` DATE NOT NULL,
  `TableNumber` INT NOT NULL,
  `CustomerId` INT UNSIGNED NOT NULL,
  `StaffId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`BookingId`),
  CONSTRAINT `CustomerId`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `LittleLemonDB`.`CustomerDetails` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `StaffId`
    FOREIGN KEY (`StaffId`)
    REFERENCES `LittleLemonDB`.`StaffInfo` (`StaffId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `CustomerId_idx` ON `LittleLemonDB`.`Bookings` (`CustomerId` ASC) VISIBLE;

CREATE INDEX `StaffId_idx` ON `LittleLemonDB`.`Bookings` (`StaffId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NOT NULL,
  `TotalCost` DECIMAL NOT NULL,
  `BookingId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`OrderId`),
  CONSTRAINT `BookingId`
    FOREIGN KEY (`BookingId`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `BookingId_idx` ON `LittleLemonDB`.`Orders` (`BookingId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatus` (
  `StatusId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DeliveryDate` DATE NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `OderId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`StatusId`),
  CONSTRAINT `OrderDeliveryId`
    FOREIGN KEY (`OderId`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `OrderDeliveryId_idx` ON `LittleLemonDB`.`OrderDeliveryStatus` (`OderId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`ItemType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`ItemType` (
  `TypeId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`TypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `ItemId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Price` DECIMAL NOT NULL,
  `TypeId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ItemId`),
  CONSTRAINT `MenuTypeId`
    FOREIGN KEY (`TypeId`)
    REFERENCES `LittleLemonDB`.`ItemType` (`TypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `MenuTypeId_idx` ON `LittleLemonDB`.`MenuItems` (`TypeId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Cuisines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Cuisines` (
  `CuisineId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `CuisineName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CuisineId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `MenuItemId` INT UNSIGNED NOT NULL,
  `CuisineId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`MenuId`),
  CONSTRAINT `MenuItemId`
    FOREIGN KEY (`MenuItemId`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`ItemId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CuisineId`
    FOREIGN KEY (`CuisineId`)
    REFERENCES `LittleLemonDB`.`Cuisines` (`CuisineId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `MenuItemId_idx` ON `LittleLemonDB`.`Menu` (`MenuItemId` ASC) VISIBLE;

CREATE INDEX `CuisineId_idx` ON `LittleLemonDB`.`Menu` (`CuisineId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderedItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderedItems` (
  `OrderId` INT UNSIGNED NOT NULL,
  `MenuId` INT UNSIGNED NOT NULL,
  `Quantity` INT NOT NULL,
  CONSTRAINT `OrderId_FK`
    FOREIGN KEY (`OrderId`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuId_FK`
    FOREIGN KEY (`MenuId`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `OrderId_FK_idx` ON `LittleLemonDB`.`OrderedItems` (`OrderId` ASC) VISIBLE;

CREATE INDEX `MenuId_FK_idx` ON `LittleLemonDB`.`OrderedItems` (`MenuId` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
