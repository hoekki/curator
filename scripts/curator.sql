-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 05. Jun 2017 um 18:59
-- Server-Version: 10.1.22-MariaDB
-- PHP-Version: 7.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `curator`
--
CREATE DATABASE IF NOT EXISTS `curator` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `curator`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `attachments`
--

DROP TABLE IF EXISTS `attachments`;
CREATE TABLE IF NOT EXISTS `attachments` (
  `AttachmentId` int(11) NOT NULL AUTO_INCREMENT,
  `RatId` int(11) NOT NULL,
  `AttachmentDate` date NOT NULL,
  `AttachmentData` longblob NOT NULL,
  `AttachmentComment` text,
  `AttachmentMimeType` varchar(127) NOT NULL,
  `AttachmentFileName` varchar(127) NOT NULL,
  PRIMARY KEY (`AttachmentId`),
  KEY `RatId` (`RatId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `drugs`
--

DROP TABLE IF EXISTS `drugs`;
CREATE TABLE IF NOT EXISTS `drugs` (
  `DrugId` int(11) NOT NULL AUTO_INCREMENT,
  `DrugName` varchar(127) NOT NULL,
  `DrugActiveSubstances` text,
  PRIMARY KEY (`DrugId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `GroupId` int(11) NOT NULL AUTO_INCREMENT,
  `GroupName` varchar(127) NOT NULL,
  PRIMARY KEY (`GroupId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `medications`
--

DROP TABLE IF EXISTS `medications`;
CREATE TABLE IF NOT EXISTS `medications` (
  `MedicationId` int(11) NOT NULL AUTO_INCREMENT,
  `RatId` int(11) NOT NULL,
  `MedicationDate` date NOT NULL,
  `DrugId` int(11) NOT NULL,
  `MedicationDoseInMicroLiter` decimal(10,2) NOT NULL,
  `MedicationFrequencyOfApplication` varchar(127) DEFAULT NULL,
  `MedicationComment` text,
  PRIMARY KEY (`MedicationId`),
  KEY `DrugId` (`DrugId`),
  KEY `RatId` (`RatId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE IF NOT EXISTS `projects` (
  `ProjectId` int(10) NOT NULL AUTO_INCREMENT,
  `ProjectName` varchar(127) NOT NULL,
  PRIMARY KEY (`ProjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rats`
--

DROP TABLE IF EXISTS `rats`;
CREATE TABLE IF NOT EXISTS `rats` (
  `RatId` int(11) NOT NULL AUTO_INCREMENT,
  `ProjectId` int(11) NOT NULL,
  `RatIdentifier` varchar(127) DEFAULT NULL,
  `RatDateOfBirth` date DEFAULT NULL,
  `RatNumber` int(11) NOT NULL,
  `RatWeightAtBirthInGrams` decimal(10,1) DEFAULT NULL,
  `RatDateOfAdmission` date DEFAULT NULL,
  `RatDateOfEuthanasia` date DEFAULT NULL,
  `RatSex` set('Male','Female') NOT NULL,
  `RatOrigin` varchar(127) NOT NULL,
  `GroupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`RatId`),
  KEY `ProjectId` (`ProjectId`),
  KEY `GroupId` (`GroupId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `treatments`
--

DROP TABLE IF EXISTS `treatments`;
CREATE TABLE IF NOT EXISTS `treatments` (
  `TreatmentId` int(11) NOT NULL AUTO_INCREMENT,
  `TreatmentDate` date NOT NULL,
  `TreatmentComment` text,
  `TreatmentText` text NOT NULL,
  `RatId` int(11) NOT NULL,
  PRIMARY KEY (`TreatmentId`),
  KEY `RatId` (`RatId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `weights`
--

DROP TABLE IF EXISTS `weights`;
CREATE TABLE IF NOT EXISTS `weights` (
  `WeightId` int(11) NOT NULL AUTO_INCREMENT,
  `RatId` int(11) NOT NULL,
  `WeightDate` date NOT NULL,
  `WeightValueInGrams` decimal(10,2) NOT NULL,
  `WeightComment` text,
  PRIMARY KEY (`WeightId`),
  KEY `RatId` (`RatId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `attachments`
--
ALTER TABLE `attachments`
  ADD CONSTRAINT `AttachmentRat` FOREIGN KEY (`RatId`) REFERENCES `rats` (`RatId`);

--
-- Constraints der Tabelle `drugs`
--
ALTER TABLE `drugs`
  ADD CONSTRAINT `DrugMedications` FOREIGN KEY (`DrugId`) REFERENCES `medications` (`DrugId`);

--
-- Constraints der Tabelle `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `GroupRats` FOREIGN KEY (`GroupId`) REFERENCES `rats` (`GroupId`);

--
-- Constraints der Tabelle `medications`
--
ALTER TABLE `medications`
  ADD CONSTRAINT `MedicationRat` FOREIGN KEY (`RatId`) REFERENCES `rats` (`RatId`);

--
-- Constraints der Tabelle `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `ProjectRats` FOREIGN KEY (`ProjectId`) REFERENCES `rats` (`ProjectId`);

--
-- Constraints der Tabelle `treatments`
--
ALTER TABLE `treatments`
  ADD CONSTRAINT `TreatmentRat` FOREIGN KEY (`RatId`) REFERENCES `rats` (`RatId`);

--
-- Constraints der Tabelle `weights`
--
ALTER TABLE `weights`
  ADD CONSTRAINT `WeightRat` FOREIGN KEY (`RatId`) REFERENCES `rats` (`RatId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
