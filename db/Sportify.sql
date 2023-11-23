-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql_db
-- Généré le : mar. 21 nov. 2023 à 15:37
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `Sportify`
--

-- --------------------------------------------------------

--
-- Structure de la table `ADMINISTRATEUR`
--

CREATE TABLE `ADMINISTRATEUR` (
  `ADMIN_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `EVENEMENT`
--

CREATE TABLE `EVENEMENT` (
  `EVENEMENT_ID` int NOT NULL,
  `ADMIN_ID` int NOT NULL,
  `NOM_EVENEMENT` varchar(255) NOT NULL,
  `LIEU_EVENEMENT` varchar(255) NOT NULL,
  `DATE_EVENEMENT` date NOT NULL,
  `DESCRIPTION_EVENT` varchar(255) DEFAULT ' ',
  `DUREE` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `MATCHS`
--

CREATE TABLE `MATCHS` (
  `MATCH_ID` int NOT NULL,
  `EQUIPE_DOMICILE` varchar(255) NOT NULL,
  `EQUIPE_EXTERIEUR` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `POST`
--

CREATE TABLE `POST` (
  `POST_ID` int NOT NULL,
  `AUTEUR_ID` int NOT NULL,
  `NOM_TOPIC` varchar(255) NOT NULL,
  `DESCRIPTION_POST` varchar(255) DEFAULT ' ',
  `NB_LIKE` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `PRONOSTIC`
--

CREATE TABLE `PRONOSTIC` (
  `PRONOSTIC_ID` int NOT NULL,
  `PRONOSTIQUEUR_ID` int NOT NULL,
  `MATCH_ID` int NOT NULL,
  `PRONOSTIQUE_EQUIPE_GAGNANTE` int NOT NULL,
  `PRONOSTIQUE_EQUIPE_PERDANTE` int NOT NULL,
  `DATE_PRONO` date NOT NULL,
  `MISE` int DEFAULT '0',
  `STATUS` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `USER_ADMIN`
--

CREATE TABLE `USER_ADMIN` (
  `USER_ID` int NOT NULL,
  `ADMIN_ID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `UTILISATEUR`
--

CREATE TABLE `UTILISATEUR` (
  `UTILISATEUR_ID` int NOT NULL,
  `PSEUDO` varchar(255) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `POINT_ACTUEL` int DEFAULT '0',
  `POINT_CLASSEMENT` int DEFAULT '0',
  `STATUS` varchar(255) NOT NULL,
  `SCORE_JEU` int DEFAULT '0',
  `NB_POST` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ADMINISTRATEUR`
--
ALTER TABLE `ADMINISTRATEUR`
  ADD PRIMARY KEY (`ADMIN_ID`);

--
-- Index pour la table `EVENEMENT`
--
ALTER TABLE `EVENEMENT`
  ADD PRIMARY KEY (`EVENEMENT_ID`),
  ADD KEY `FK_ADMIN_EVENT` (`ADMIN_ID`);

--
-- Index pour la table `MATCHS`
--
ALTER TABLE `MATCHS`
  ADD PRIMARY KEY (`MATCH_ID`);

--
-- Index pour la table `POST`
--
ALTER TABLE `POST`
  ADD PRIMARY KEY (`POST_ID`),
  ADD KEY `FK_USERID` (`AUTEUR_ID`);

--
-- Index pour la table `PRONOSTIC`
--
ALTER TABLE `PRONOSTIC`
  ADD PRIMARY KEY (`PRONOSTIC_ID`),
  ADD KEY `FK_PRONOSTIQUEUR` (`PRONOSTIQUEUR_ID`),
  ADD KEY `FK_MATCH` (`MATCH_ID`);

--
-- Index pour la table `USER_ADMIN`
--
ALTER TABLE `USER_ADMIN`
  ADD PRIMARY KEY (`USER_ID`,`ADMIN_ID`),
  ADD KEY `FK_ADMIN` (`ADMIN_ID`);

--
-- Index pour la table `UTILISATEUR`
--
ALTER TABLE `UTILISATEUR`
  ADD PRIMARY KEY (`UTILISATEUR_ID`),
  ADD UNIQUE KEY `U_PS` (`PSEUDO`),
  ADD UNIQUE KEY `U_E` (`EMAIL`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `EVENEMENT`
--
ALTER TABLE `EVENEMENT`
  ADD CONSTRAINT `FK_ADMIN_EVENT` FOREIGN KEY (`ADMIN_ID`) REFERENCES `ADMINISTRATEUR` (`ADMIN_ID`);

--
-- Contraintes pour la table `POST`
--
ALTER TABLE `POST`
  ADD CONSTRAINT `FK_USERID` FOREIGN KEY (`AUTEUR_ID`) REFERENCES `UTILISATEUR` (`UTILISATEUR_ID`);

--
-- Contraintes pour la table `PRONOSTIC`
--
ALTER TABLE `PRONOSTIC`
  ADD CONSTRAINT `FK_MATCH` FOREIGN KEY (`MATCH_ID`) REFERENCES `MATCHS` (`MATCH_ID`),
  ADD CONSTRAINT `FK_PRONOSTIQUEUR` FOREIGN KEY (`PRONOSTIQUEUR_ID`) REFERENCES `UTILISATEUR` (`UTILISATEUR_ID`);

--
-- Contraintes pour la table `USER_ADMIN`
--
ALTER TABLE `USER_ADMIN`
  ADD CONSTRAINT `FK_ADMIN` FOREIGN KEY (`ADMIN_ID`) REFERENCES `ADMINISTRATEUR` (`ADMIN_ID`),
  ADD CONSTRAINT `FK_USER` FOREIGN KEY (`USER_ID`) REFERENCES `UTILISATEUR` (`UTILISATEUR_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;