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
  `NOM_EVENEMENT` varchar(25) NOT NULL,
  `DATE_EVENEMENT` date NOT NULL,
  `EQUIPE_DOMICILE` varchar(25) NOT NULL,
  `EQUIPE_EXTERIEUR` varchar(25) NOT NULL,
  `COTE_DOMICILE` int NOT NULL,
  `COTE_EXTERIEUR` int NOT NULL,
  `CAT_SPORT` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `MATCHS`
--

CREATE TABLE `MATCHS` (
  `MATCH_ID` int NOT NULL,
  `EQUIPE_DOMICILE` varchar(25) NOT NULL,
  `EQUIPE_EXTERIEUR` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `POST`
--

CREATE TABLE `POST` (
  `POST_ID` int NOT NULL,
  `AUTEUR_ID` int NOT NULL,
  `NOM_TOPIC` varchar(25) NOT NULL,
  `DESCRIPTION_POST` varchar(25) DEFAULT ' ',
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
  `STATUS` varchar(25) NOT NULL
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
  `UTILISATEUR_ID` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `PSEUDO` varchar(50) NOT NULL,
  `EMAIL` varchar(100) NOT NULL,
  `MOT_DE_PASSE` varchar(150) NOT NULL,
  `POINT_ACTUEL` int DEFAULT '0',
  `POINT_CLASSEMENT` int DEFAULT '0',
  `STATUS` int DEFAULT 0,
  `SCORE_JEU` int DEFAULT '0'

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- --------------------------------------------------------

--
-- Structure de la table `ITEMS`
--

CREATE TABLE `ITEMS` (
  `ITEM_ID` int NOT NULL,
  `NOM_ITEM` varchar(25) NOT NULL,
  `TYPE` varchar(25) NOT NULL,
  `DESCRIPTION` varchar(256) NOT NULL,
  `PRIX` int NOT NULL,
  `COULEUR` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `INVENTAIRE`
--

CREATE TABLE `INVENTAIRE` (
  `INVENTAIRE_ID` int NOT NULL,
  `UTILISATEUR_ID` int NOT NULL,
  `ITEM_ID` int NOT NULL
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
-- Index pour la table `ITEMS`
--
ALTER TABLE `ITEMS`
  ADD PRIMARY KEY (`ITEM_ID`);

--
-- Index pour la table `INVENTAIRE`
--
ALTER TABLE `INVENTAIRE`
  ADD PRIMARY KEY (`INVENTAIRE_ID`),
  ADD KEY `FK_UTILISATEUR` (`UTILISATEUR_ID`),
  ADD KEY `FK_ITEM` (`ITEM_ID`);


--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `EVENEMENT`
--

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

--
-- Contraintes pour la table `INVENTAIRE`
--

ALTER TABLE `INVENTAIRE`
  ADD CONSTRAINT `FK_UTILISATEUR` FOREIGN KEY (`UTILISATEUR_ID`) REFERENCES `UTILISATEUR` (`UTILISATEUR_ID`),
  ADD CONSTRAINT `FK_ITEM` FOREIGN KEY (`ITEM_ID`) REFERENCES `ITEMS` (`ITEM_ID`);
COMMIT;



INSERT INTO EVENEMENT (EVENEMENT_ID, NOM_EVENEMENT, DATE_EVENEMENT, EQUIPE_DOMICILE, EQUIPE_EXTERIEUR, COTE_DOMICILE, COTE_EXTERIEUR, CAT_SPORT) VALUES (1, 'LIGUE 1', '2023-11-21', 'PSG', 'OM', 1.5, 2.5, 'Football');
INSERT INTO EVENEMENT (EVENEMENT_ID, NOM_EVENEMENT, DATE_EVENEMENT, EQUIPE_DOMICILE, EQUIPE_EXTERIEUR, COTE_DOMICILE, COTE_EXTERIEUR, CAT_SPORT) VALUES (2, 'LIGUE 1', '2023-10-23', 'OL', 'ASSE', 1.5, 2.5, 'Football');
INSERT INTO EVENEMENT (EVENEMENT_ID, NOM_EVENEMENT, DATE_EVENEMENT, EQUIPE_DOMICILE, EQUIPE_EXTERIEUR, COTE_DOMICILE, COTE_EXTERIEUR, CAT_SPORT) VALUES (3, 'LIGA', '2023-12-21', 'BARCELONA', 'REAL MADRID', 1.5, 2.5, 'Football');
INSERT INTO EVENEMENT (EVENEMENT_ID, NOM_EVENEMENT, DATE_EVENEMENT, EQUIPE_DOMICILE, EQUIPE_EXTERIEUR, COTE_DOMICILE, COTE_EXTERIEUR, CAT_SPORT) VALUES (4, 'LIGA', '2023-12-21', 'ATLETICO MADRID', 'SEVILLE', 1.5, 2.5, 'Football');

INSERT INTO EVENEMENT (EVENEMENT_ID, NOM_EVENEMENT, DATE_EVENEMENT, EQUIPE_DOMICILE, EQUIPE_EXTERIEUR, COTE_DOMICILE, COTE_EXTERIEUR, CAT_SPORT) VALUES (2, 'LIGA', '2023-11-21', 'BARCELONE', 'REAL MADRID', 1.5, 2.5, 'Football');

-- Insérer un utilisateur avec des valeurs spécifiques
INSERT INTO `UTILISATEUR` (`UTILISATEUR_ID`, `PSEUDO`, `EMAIL`, `MOT_DE_PASSE`, `POINT_ACTUEL`, `POINT_CLASSEMENT`, `STATUS`, `SCORE_JEU`)
VALUES (1, 'Utilisateur1', 'utilisateur1@email.com', 'motdepasse1', 100, 50, 1, 500);

-- Insérer un autre utilisateur
INSERT INTO `UTILISATEUR` (`UTILISATEUR_ID`, `PSEUDO`, `EMAIL`, `MOT_DE_PASSE`, `POINT_ACTUEL`, `POINT_CLASSEMENT`, `STATUS`, `SCORE_JEU`)
VALUES (2, 'Utilisateur2', 'utilisateur2@email.com', 'motdepasse2', 150, 75, 1, 700);

-- Insérer un utilisateur avec des valeurs par défaut
INSERT INTO `UTILISATEUR` (`UTILISATEUR_ID`, `PSEUDO`, `EMAIL`, `MOT_DE_PASSE`)
VALUES (3, 'Utilisateur3', 'utilisateur3@email.com', 'motdepasse3');


/*test insertion 6 items différents*/
INSERT INTO ITEMS (ITEM_ID, NOM_ITEM, TYPE, DESCRIPTION, PRIX, COULEUR) VALUES (1, 'Chapeau', 'Chapeau', 'Chapeau de cowboy', 100, 'Marron');
INSERT INTO ITEMS (ITEM_ID, NOM_ITEM, TYPE, DESCRIPTION, PRIX, COULEUR) VALUES (2, 'T-shirt', 'Chapeau', 'T-shirt de cowboy', 100, 'Noir');
INSERT INTO ITEMS (ITEM_ID, NOM_ITEM, TYPE, DESCRIPTION, PRIX, COULEUR) VALUES (3, 'Pantalon', 'Chapeau', 'Pantalon de cowboy', 100, 'Blanc');
INSERT INTO ITEMS (ITEM_ID, NOM_ITEM, TYPE, DESCRIPTION, PRIX, COULEUR) VALUES (4, 'Chaussures', 'Chapeau', 'Chaussures de cowboy', 100, 'Rouge');
INSERT INTO ITEMS (ITEM_ID, NOM_ITEM, TYPE, DESCRIPTION, PRIX, COULEUR) VALUES (5, 'Montres', 'Chapeau', 'Montres de cowboy', 100, 'Bleu');
INSERT INTO ITEMS (ITEM_ID, NOM_ITEM, TYPE, DESCRIPTION, PRIX, COULEUR) VALUES (6, 'Sac', 'Chapeau', 'Sac de cowboy', 100, 'Vert');




/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;