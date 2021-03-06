-- MySQL Script generated by MySQL Workbench
-- Thu 29 Apr 2021 21:41:36 SAST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema IEC_2021
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `IEC_2021` ;

-- -----------------------------------------------------
-- Schema IEC_2021
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `IEC_2021` ;
USE `IEC_2021` ;

-- -----------------------------------------------------
-- Table `IEC_2021`.`iec_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`iec_member` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`iec_member` (
  `iec_member_id_number` VARCHAR(13) NOT NULL,
  `first_name` VARCHAR(25) NOT NULL,
  `last_name` VARCHAR(25) NOT NULL,
  `password_salt` INT(4) UNSIGNED NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `password_hash` VARCHAR(255) NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`iec_member_id_number`),
  UNIQUE INDEX `iec_member_id_UNIQUE` (`iec_member_id_number` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `IEC_2021`.`upper_municipality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`upper_municipality` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`upper_municipality` (
  `upper_muni_id` VARCHAR(10) NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `is_district` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`upper_muni_id`),
  UNIQUE INDEX `ward_id_UNIQUE` (`upper_muni_id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `IEC_2021`.`local_municipality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`local_municipality` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`local_municipality` (
  `local_muni_id` VARCHAR(10) NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `upper_muni_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`local_muni_id`, `upper_muni_id`),
  UNIQUE INDEX `local_muni_id_UNIQUE` (`local_muni_id` ASC) VISIBLE,
  INDEX `fk_local_municipality_upper_municipality_idx` (`upper_muni_id` ASC) VISIBLE,
  CONSTRAINT `fk_local_municipality_upper_municipality`
    FOREIGN KEY (`upper_muni_id`)
    REFERENCES `IEC_2021`.`upper_municipality` (`upper_muni_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `IEC_2021`.`ward`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`ward` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`ward` (
  `ward_id` INT(4) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `local_muni_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`ward_id`, `local_muni_id`),
  UNIQUE INDEX `ward_id_UNIQUE` (`ward_id` ASC) VISIBLE,
  INDEX `fk_ward_local_municipality1_idx` (`local_muni_id` ASC) VISIBLE,
  CONSTRAINT `fk_ward_local_municipality1`
    FOREIGN KEY (`local_muni_id`)
    REFERENCES `IEC_2021`.`local_municipality` (`local_muni_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `IEC_2021`.`voter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`voter` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`voter` (
  `voter_id_number` VARCHAR(13) NOT NULL,
  `first_name` VARCHAR(25) NOT NULL,
  `last_name` VARCHAR(25) NOT NULL,
  `registration_code` VARCHAR(10) NOT NULL,
  `ward_id` INT(4) NOT NULL,
  `iec_member_registrant_id` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`voter_id_number`, `ward_id`, `iec_member_registrant_id`),
  UNIQUE INDEX `voter_id_number_UNIQUE` (`voter_id_number` ASC) VISIBLE,
  UNIQUE INDEX `registration_code_UNIQUE` (`registration_code` ASC) VISIBLE,
  INDEX `fk_voter_ward1_idx` (`ward_id` ASC) VISIBLE,
  INDEX `fk_voter_iec_member1_idx` (`iec_member_registrant_id` ASC) VISIBLE,
  CONSTRAINT `fk_voter_ward1`
    FOREIGN KEY (`ward_id`)
    REFERENCES `IEC_2021`.`ward` (`ward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voter_iec_member1`
    FOREIGN KEY (`iec_member_registrant_id`)
    REFERENCES `IEC_2021`.`iec_member` (`iec_member_id_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `IEC_2021`.`party`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`party` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`party` (
  `party_id` INT(4) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`party_id`),
  UNIQUE INDEX `party_id_UNIQUE` (`party_id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `IEC_2021`.`ward_candidate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`ward_candidate` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`ward_candidate` (
  `candidate_id` INT(4) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `ward_id` INT(4) NOT NULL,
  `party_id` INT(4) NOT NULL,
  PRIMARY KEY (`candidate_id`, `ward_id`, `party_id`),
  UNIQUE INDEX `candidate_id_UNIQUE` (`candidate_id` ASC) VISIBLE,
  INDEX `fk_ward_candidate_ward1_idx` (`ward_id` ASC) VISIBLE,
  INDEX `fk_ward_candidate_party1_idx` (`party_id` ASC) VISIBLE,
  CONSTRAINT `fk_ward_candidate_ward1`
    FOREIGN KEY (`ward_id`)
    REFERENCES `IEC_2021`.`ward` (`ward_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ward_candidate_party1`
    FOREIGN KEY (`party_id`)
    REFERENCES `IEC_2021`.`party` (`party_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `IEC_2021`.`vote_ward`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`vote_ward` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`vote_ward` (
  `vote_id` INT(8) NOT NULL AUTO_INCREMENT,
  `candidate_id` INT(4) NOT NULL,
  PRIMARY KEY (`vote_id`, `candidate_id`),
  UNIQUE INDEX `vote_id_UNIQUE` (`vote_id` ASC) VISIBLE,
  INDEX `fk_vote_ward_ward_candidate1_idx` (`candidate_id` ASC) VISIBLE,
  CONSTRAINT `fk_vote_ward_ward_candidate1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `IEC_2021`.`ward_candidate` (`candidate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `IEC_2021`.`vote_local_municipality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`vote_local_municipality` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`vote_local_municipality` (
  `vote_id` INT(8) NOT NULL AUTO_INCREMENT,
  `local_muni_id` VARCHAR(10) NOT NULL,
  `party_id` INT(4) NOT NULL,
  PRIMARY KEY (`vote_id`, `local_muni_id`, `party_id`),
  UNIQUE INDEX `vote_id_UNIQUE` (`vote_id` ASC) VISIBLE,
  INDEX `fk_vote_local_municipality_local_municipality1_idx` (`local_muni_id` ASC) VISIBLE,
  INDEX `fk_vote_local_municipality_party1_idx` (`party_id` ASC) VISIBLE,
  CONSTRAINT `fk_vote_local_municipality_local_municipality1`
    FOREIGN KEY (`local_muni_id`)
    REFERENCES `IEC_2021`.`local_municipality` (`local_muni_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vote_local_municipality_party1`
    FOREIGN KEY (`party_id`)
    REFERENCES `IEC_2021`.`party` (`party_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `IEC_2021`.`vote_upper_municipality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IEC_2021`.`vote_upper_municipality` ;

CREATE TABLE IF NOT EXISTS `IEC_2021`.`vote_upper_municipality` (
  `vote_id` INT(8) NOT NULL AUTO_INCREMENT,
  `party_party_id` INT(4) NOT NULL,
  `upper_municipality_upper_muni_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`vote_id`, `party_party_id`, `upper_municipality_upper_muni_id`),
  UNIQUE INDEX `vote_id_UNIQUE` (`vote_id` ASC) VISIBLE,
  INDEX `fk_vote_upper_municipality_party1_idx` (`party_party_id` ASC) VISIBLE,
  INDEX `fk_vote_upper_municipality_upper_municipality1_idx` (`upper_municipality_upper_muni_id` ASC) VISIBLE,
  CONSTRAINT `fk_vote_upper_municipality_party1`
    FOREIGN KEY (`party_party_id`)
    REFERENCES `IEC_2021`.`party` (`party_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vote_upper_municipality_upper_municipality1`
    FOREIGN KEY (`upper_municipality_upper_muni_id`)
    REFERENCES `IEC_2021`.`upper_municipality` (`upper_muni_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
