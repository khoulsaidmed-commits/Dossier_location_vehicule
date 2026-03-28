-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 22 mars 2026 à 14:11
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `kamk_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `agences`
--

DROP TABLE IF EXISTS `agences`;
CREATE TABLE IF NOT EXISTS `agences` (
  `id_agence` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom_agence` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'KAMK Location',
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ville` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Djibouti-Ville',
  `telephone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `horaires` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Lun-Sam 7h-20h / Dim 8h-18h',
  `latitude` decimal(10,7) DEFAULT '11.5895000',
  `longitude` decimal(10,7) DEFAULT '43.1445000',
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lat` decimal(10,7) DEFAULT '11.5892000',
  `lng` decimal(10,7) DEFAULT '43.1456000',
  PRIMARY KEY (`id_agence`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Agences KAMK';

--
-- Déchargement des données de la table `agences`
--

INSERT INTO `agences` (`id_agence`, `nom_agence`, `adresse`, `ville`, `telephone`, `email`, `horaires`, `latitude`, `longitude`, `actif`, `created_at`, `lat`, `lng`) VALUES
(1, 'KAMK Location de Véhicules', 'Venise, Djibouti-Ville', 'Djibouti-Ville', '+253 21 35 00 00', 'contact@kamk.dj', 'Lun-Sam 7h-20h / Dim 8h-18h', 11.5895000, 43.1445000, 1, '2026-03-11 20:29:45', 11.5892000, 43.1456000);

-- --------------------------------------------------------

--
-- Structure de la table `alertes_systeme`
--

DROP TABLE IF EXISTS `alertes_systeme`;
CREATE TABLE IF NOT EXISTS `alertes_systeme` (
  `id_alerte` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_alerte` enum('vehicule_non_retourne','assurance_expirante','maintenance_due','document_expire','paiement_retard','incident_non_traite','gps_signal_perdu','vitesse_excessive','zone_interdite','caution_non_liberee') COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_vehicule` int UNSIGNED DEFAULT NULL,
  `id_client` int UNSIGNED DEFAULT NULL,
  `id_employe` int UNSIGNED DEFAULT NULL,
  `id_reservation` int UNSIGNED DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `priorite` enum('basse','normale','haute','critique') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normale',
  `traitee` tinyint(1) NOT NULL DEFAULT '0',
  `traitee_par` int UNSIGNED DEFAULT NULL,
  `date_traitement` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_alerte`),
  KEY `idx_non_traitees` (`traitee`,`priorite`),
  KEY `idx_alertes_priorite` (`priorite`,`traitee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Alertes automatiques du système';

-- --------------------------------------------------------

--
-- Structure de la table `annotations`
--

DROP TABLE IF EXISTS `annotations`;
CREATE TABLE IF NOT EXISTS `annotations` (
  `id_annotation` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_employe` int UNSIGNED NOT NULL,
  `id_client` int UNSIGNED DEFAULT NULL,
  `id_reservation` int UNSIGNED DEFAULT NULL,
  `id_vehicule` int UNSIGNED DEFAULT NULL,
  `contenu` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_annotation` enum('note','alerte','rappel','observation') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'note',
  `visible_client` tinyint(1) NOT NULL DEFAULT '0',
  `date_rappel` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_annotation`),
  KEY `id_employe` (`id_employe`),
  KEY `id_client` (`id_client`),
  KEY `id_reservation` (`id_reservation`),
  KEY `id_vehicule` (`id_vehicule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Annotations internes employés';

-- --------------------------------------------------------

--
-- Structure de la table `annulations`
--

DROP TABLE IF EXISTS `annulations`;
CREATE TABLE IF NOT EXISTS `annulations` (
  `id_annulation` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_reservation` int UNSIGNED NOT NULL,
  `id_client` int UNSIGNED NOT NULL,
  `id_politique` int UNSIGNED DEFAULT '2',
  `date_annulation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `raison` text COLLATE utf8mb4_unicode_ci,
  `jours_avant_depart` int NOT NULL DEFAULT '0',
  `montant_total` decimal(10,2) NOT NULL,
  `pourcentage_frais` decimal(5,2) NOT NULL DEFAULT '0.00',
  `montant_frais` decimal(10,2) NOT NULL DEFAULT '0.00',
  `montant_rembours` decimal(10,2) NOT NULL DEFAULT '0.00',
  `statut` enum('en_attente','remboursement_en_cours','remboursement_effectue','annule_sans_remboursement') COLLATE utf8mb4_unicode_ci DEFAULT 'en_attente',
  `remboursement_effectue` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_annulation`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `annulations`
--

INSERT INTO `annulations` (`id_annulation`, `id_reservation`, `id_client`, `id_politique`, `date_annulation`, `raison`, `jours_avant_depart`, `montant_total`, `pourcentage_frais`, `montant_frais`, `montant_rembours`, `statut`, `remboursement_effectue`, `created_at`) VALUES
(1, 4, 1, 2, '2026-03-21 21:33:10', 'Changement de planning', 1, 195.00, 100.00, 195.00, 0.00, 'annule_sans_remboursement', 0, '2026-03-21 18:33:10');

-- --------------------------------------------------------

--
-- Structure de la table `assurances`
--

DROP TABLE IF EXISTS `assurances`;
CREATE TABLE IF NOT EXISTS `assurances` (
  `id_assurance` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vehicule` int UNSIGNED NOT NULL,
  `compagnie` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_police` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_couverture` enum('tiers','tous_risques','vol','bris_glace') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tous_risques',
  `montant_prime` decimal(8,2) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `franchise` decimal(8,2) DEFAULT '0.00',
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `document_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_assurance`),
  UNIQUE KEY `numero_police` (`numero_police`),
  KEY `id_vehicule` (`id_vehicule`),
  KEY `idx_expiry` (`date_fin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Assurances véhicules';

-- --------------------------------------------------------

--
-- Structure de la table `avis_clients`
--

DROP TABLE IF EXISTS `avis_clients`;
CREATE TABLE IF NOT EXISTS `avis_clients` (
  `id_avis` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_client` int UNSIGNED NOT NULL,
  `id_reservation` int UNSIGNED NOT NULL,
  `note_globale` tinyint UNSIGNED NOT NULL,
  `note_vehicule` tinyint UNSIGNED DEFAULT NULL,
  `note_service` tinyint UNSIGNED DEFAULT NULL,
  `note_rapport_qualite` tinyint UNSIGNED DEFAULT NULL,
  `commentaire` text COLLATE utf8mb4_unicode_ci,
  `reponse_agence` text COLLATE utf8mb4_unicode_ci COMMENT 'Réponse de l agence',
  `repondu_par` int UNSIGNED DEFAULT NULL,
  `date_reponse` datetime DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `featured` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Mis en avant sur la page d accueil',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_avis`),
  UNIQUE KEY `id_reservation` (`id_reservation`),
  KEY `id_client` (`id_client`),
  KEY `repondu_par` (`repondu_par`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `capacites`
--

DROP TABLE IF EXISTS `capacites`;
CREATE TABLE IF NOT EXISTS `capacites` (
  `id_capacite` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vehicule` int UNSIGNED NOT NULL,
  `nb_places` tinyint NOT NULL DEFAULT '5',
  `volume_coffre` float DEFAULT NULL COMMENT 'Litres',
  `poids_max_charge` float DEFAULT NULL COMMENT 'kg',
  `type_utilisation` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ville, tout-terrain, etc.',
  `equipements` json DEFAULT NULL COMMENT 'Clim, GPS, Bluetooth, etc.',
  PRIMARY KEY (`id_capacite`),
  UNIQUE KEY `id_vehicule` (`id_vehicule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cautions`
--

DROP TABLE IF EXISTS `cautions`;
CREATE TABLE IF NOT EXISTS `cautions` (
  `id_caution` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_reservation` int UNSIGNED NOT NULL,
  `id_client` int UNSIGNED NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `methode` enum('especes','carte_bancaire','cheque','virement') COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_versement` datetime NOT NULL,
  `date_liberation` datetime DEFAULT NULL,
  `statut` enum('versee','liberee','saisie_partielle','saisie_totale') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'versee',
  `montant_saisi` decimal(10,2) DEFAULT '0.00' COMMENT 'Si dommages',
  `motif_saisie` text COLLATE utf8mb4_unicode_ci,
  `libere_par` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_caution`),
  UNIQUE KEY `id_reservation` (`id_reservation`),
  KEY `id_client` (`id_client`),
  KEY `libere_par` (`libere_par`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Gestion des cautions';

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id_client` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ville` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Djibouti-Ville',
  `date_naissance` date DEFAULT NULL,
  `nationalite` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT 'Djiboutienne',
  `permis_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_profil` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `points_fidelite` int UNSIGNED NOT NULL DEFAULT '0',
  `niveau_fidelite` enum('Bronze','Argent','Or','Platine') COLLATE utf8mb4_unicode_ci DEFAULT 'Bronze',
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `email_verifie` tinyint(1) NOT NULL DEFAULT '0',
  `statut_compte` enum('en_attente','valide','suspendu','refuse') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en_attente',
  `token_verification` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token_reset` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token_expiry` datetime DEFAULT NULL,
  `tentatives_connexion` tinyint NOT NULL DEFAULT '0',
  `compte_bloque` tinyint(1) NOT NULL DEFAULT '0',
  `bloque_jusqu_au` datetime DEFAULT NULL,
  `en_ligne` tinyint(1) NOT NULL DEFAULT '0',
  `derniere_connexion` datetime DEFAULT NULL,
  `langue` enum('fr','en','ar') COLLATE utf8mb4_unicode_ci DEFAULT 'fr',
  `notifications_email` tinyint(1) NOT NULL DEFAULT '1',
  `notifications_sms` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type_permis` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_permis` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_obtention_permis` date DEFAULT NULL,
  `alerte_baisse_prix` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = client veut être notifié des baisses de prix',
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_email` (`email`),
  KEY `idx_fidelite` (`niveau_fidelite`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Clients de l agence KAMK';

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id_client`, `nom`, `prenom`, `email`, `telephone`, `mot_de_passe`, `adresse`, `ville`, `date_naissance`, `nationalite`, `permis_type`, `photo_profil`, `points_fidelite`, `niveau_fidelite`, `actif`, `email_verifie`, `statut_compte`, `token_verification`, `token_reset`, `token_expiry`, `tentatives_connexion`, `compte_bloque`, `bloque_jusqu_au`, `en_ligne`, `derniere_connexion`, `langue`, `notifications_email`, `notifications_sms`, `created_at`, `updated_at`, `type_permis`, `numero_permis`, `date_obtention_permis`, `alerte_baisse_prix`) VALUES
(1, 'SOULEIMAN', 'Kad', 'abdirachidhochkadar@gmail.com', '+25377020761', '$2y$12$VyJKjhrc4Wi7wQXJkzATiul/4P9aNUpFogt/sI3f1mU2QtaXqyMCi', 'Djibouti,balbala', 'Djibouti', NULL, 'Djiboutienne', 'B', 'uploads/profils/photo_69ba658fedc262.71142947.jpg', 0, 'Bronze', 1, 1, 'valide', NULL, NULL, NULL, 0, 0, NULL, 0, '2026-03-22 15:00:07', 'fr', 1, 1, '2026-03-13 14:52:17', '2026-03-22 12:13:07', NULL, NULL, NULL, 0),
(3, 'TEST', 'Client', 'test@kamk.dj', '+25377000001', '$2y$12$YJFrKoE1TWWSI0IMWjIPZOEwhVqMvmhHWyBAtX23PrTzGowgqxYV6', '', 'Djibouti-Ville', NULL, 'Djiboutienne', 'B', NULL, 0, 'Bronze', 1, 1, 'valide', NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'fr', 1, 1, '2026-03-13 14:58:41', '2026-03-14 22:16:44', NULL, NULL, NULL, 0),
(4, 'SAID', 'Kouloud', 'khoulsaidmed@gmail.com', '+25377448536', '$2y$12$/8IHQ6FIp4gxJsQzgTQz1OBIzvrV9aolJAaitDANeoqeXpoAc2Xx2', 'Djibouti,balbala', 'Djibouti', NULL, 'Djiboutienne', NULL, NULL, 0, 'Bronze', 1, 1, 'valide', NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'fr', 1, 1, '2026-03-14 21:39:42', '2026-03-15 11:32:20', NULL, NULL, NULL, 0),
(8, 'RAMZI', 'Ayman', 'aymanramziahmed980@gmail.com', '+253407722', '$2y$12$xrp61BNKIrIjS.cGPn8xbOWeDsACzVBbiI8JCxSlS0/WFzGXynXzy', 'Djibouti,balbala', 'Djibouti', NULL, 'Djiboutienne', 'C', 'uploads/profils/Ayman_Ramzi_1773529866.jpeg', 0, 'Bronze', 1, 1, 'valide', NULL, NULL, NULL, 0, 0, NULL, 0, '2026-03-15 02:17:00', 'fr', 1, 1, '2026-03-14 23:11:06', '2026-03-14 23:24:30', NULL, NULL, NULL, 0),
(9, 'ABDIRACHID HOCH', 'Arafo', 'koulsaidmed@gmail.com', '+25377020762', '$2y$12$ObX92Z36TAzJ1nL//fy1iebJDTxMiWqfKQlArQgNQa5AV5m1h4YEO', 'Djibouti,balbala', 'Djibouti', NULL, 'Djiboutienne', 'B', 'uploads/profils/Arafo_Abdirachid_Hoch_1773571172.jpg', 0, 'Bronze', 1, 1, 'valide', NULL, NULL, NULL, 1, 0, NULL, 0, NULL, 'fr', 1, 1, '2026-03-15 10:39:32', '2026-03-22 13:48:49', NULL, NULL, NULL, 0),
(10, 'MARWO', 'Osman', 'marwoosman11@gmail.com', '77141013', '$2y$12$hV1WcLxfr6cb6XB6vwthgOoLYSl2nAiPoIS2KOtbSvxM2QR9brrgm', 'Djibouti,balbala', 'Djibouti', NULL, 'Djiboutienne', 'C', 'uploads/profils/Osman_Marwo_1774031246.jpeg', 0, 'Bronze', 1, 1, 'valide', NULL, NULL, NULL, 0, 0, NULL, 0, NULL, 'fr', 1, 1, '2026-03-20 18:27:26', '2026-03-20 18:31:06', NULL, NULL, NULL, 0),
(11, 'ABDIRACHID', 'Hoch', 'abdirachidhoch12@gmail.com', '+25377629921', '$2y$12$VSgZh1HijQxPBY97JtssAOiyjHRaVDMi.dW4ZMu5Fc.aOIWZxhw0m', 'Djibouti,balbala', 'Djibouti', NULL, 'Djiboutienne', 'B', 'uploads/profils/Hoch_Abdirachid_1774108897.png', 0, 'Bronze', 1, 1, 'valide', NULL, NULL, NULL, 0, 0, NULL, 0, '2026-03-22 17:01:54', 'fr', 1, 1, '2026-03-21 16:01:37', '2026-03-22 14:06:54', NULL, NULL, NULL, 0),
(12, 'MR', 'Moubarak', 'moubarekbarre@gmail.com', '+25377650012', '$2y$12$Udjhz/2QFALp9S9E2i1xFu185/1e7cmclzkxUuLCZC/k.OhnCvkp2', 'Djibouti,balbala', 'Djibouti', NULL, 'Djiboutienne', 'B', 'uploads/profils/Moubarak_Mr_1774181854.jpeg', 0, 'Bronze', 1, 1, 'valide', NULL, NULL, NULL, 0, 0, NULL, 0, '2026-03-22 15:39:54', 'fr', 1, 1, '2026-03-22 12:17:34', '2026-03-22 13:48:36', NULL, NULL, NULL, 0);

--
-- Déclencheurs `clients`
--
DROP TRIGGER IF EXISTS `trg_compte_bloque`;
DELIMITER $$
CREATE TRIGGER `trg_compte_bloque` AFTER UPDATE ON `clients` FOR EACH ROW BEGIN
    IF NEW.tentatives_connexion >= 5 AND OLD.tentatives_connexion < 5 THEN
        UPDATE clients SET compte_bloque = 1,
            bloque_jusqu_au = DATE_ADD(NOW(), INTERVAL 30 MINUTE)
        WHERE id_client = NEW.id_client;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `contrats`
--

DROP TABLE IF EXISTS `contrats`;
CREATE TABLE IF NOT EXISTS `contrats` (
  `id_contrat` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_reservation` int UNSIGNED NOT NULL,
  `id_client` int UNSIGNED NOT NULL,
  `id_employe` int UNSIGNED NOT NULL,
  `numero_contrat` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_contrat` datetime NOT NULL,
  `depot_garantie` decimal(8,2) NOT NULL DEFAULT '0.00',
  `conditions` text COLLATE utf8mb4_unicode_ci,
  `etat_depart` enum('excellent','bon','moyen','mauvais') COLLATE utf8mb4_unicode_ci DEFAULT 'bon',
  `etat_retour` enum('excellent','bon','moyen','mauvais') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dommages_constates` text COLLATE utf8mb4_unicode_ci,
  `frais_dommages` decimal(8,2) DEFAULT '0.00',
  `signe_client` tinyint(1) NOT NULL DEFAULT '0',
  `signe_employe` tinyint(1) NOT NULL DEFAULT '0',
  `date_signature` datetime DEFAULT NULL,
  `signature_client_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statut` enum('brouillon','actif','termine','litige','annule') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'brouillon',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_contrat`),
  UNIQUE KEY `id_reservation` (`id_reservation`),
  UNIQUE KEY `numero_contrat` (`numero_contrat`),
  KEY `id_client` (`id_client`),
  KEY `id_employe` (`id_employe`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Contrats de location signés';

--
-- Déchargement des données de la table `contrats`
--

INSERT INTO `contrats` (`id_contrat`, `id_reservation`, `id_client`, `id_employe`, `numero_contrat`, `date_contrat`, `depot_garantie`, `conditions`, `etat_depart`, `etat_retour`, `dommages_constates`, `frais_dommages`, `signe_client`, `signe_employe`, `date_signature`, `signature_client_path`, `pdf_path`, `statut`, `created_at`) VALUES
(1, 1, 1, 2, 'KAMK-C-2026-00001', '2026-03-20 01:16:04', 0.00, NULL, 'bon', NULL, NULL, 0.00, 0, 1, '2026-03-20 14:17:27', NULL, NULL, 'termine', '2026-03-19 22:16:04'),
(2, 4, 1, 2, 'KAMK-C-2026-00004', '2026-03-20 22:29:11', 0.00, NULL, 'bon', NULL, NULL, 0.00, 127, 0, NULL, NULL, NULL, '', '2026-03-20 19:29:11');

-- --------------------------------------------------------

--
-- Structure de la table `documents_client`
--

DROP TABLE IF EXISTS `documents_client`;
CREATE TABLE IF NOT EXISTS `documents_client` (
  `id_document` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_client` int UNSIGNED NOT NULL,
  `id_reservation` int UNSIGNED DEFAULT NULL,
  `type_document` enum('permis','cni','passeport','justificatif_domicile','carte_bancaire','autre') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fichier_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom_original` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taille_ko` int UNSIGNED DEFAULT NULL,
  `date_expiration` date DEFAULT NULL,
  `statut_validation` enum('en_attente','valide','refuse','expire') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en_attente',
  `valide_par` int UNSIGNED DEFAULT NULL,
  `date_validation` datetime DEFAULT NULL,
  `motif_refus` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_document`),
  KEY `id_client` (`id_client`),
  KEY `id_reservation` (`id_reservation`),
  KEY `valide_par` (`valide_par`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Documents d identité et permis';

-- --------------------------------------------------------

--
-- Structure de la table `employes`
--

DROP TABLE IF EXISTS `employes`;
CREATE TABLE IF NOT EXISTS `employes` (
  `id_employe` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_agence` int UNSIGNED NOT NULL,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `poste` enum('accueil','contrat','maintenance','livreur','chef_agence','chef_maintenance','admin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `matricule` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_embauche` date NOT NULL,
  `salaire` decimal(10,2) DEFAULT NULL,
  `photo_profil` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `en_ligne` tinyint(1) NOT NULL DEFAULT '0',
  `derniere_connexion` datetime DEFAULT NULL,
  `token_reset` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_employe`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `matricule` (`matricule`),
  KEY `id_agence` (`id_agence`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Employés KAMK';

--
-- Déchargement des données de la table `employes`
--

INSERT INTO `employes` (`id_employe`, `id_agence`, `nom`, `prenom`, `email`, `telephone`, `mot_de_passe`, `poste`, `matricule`, `date_embauche`, `salaire`, `photo_profil`, `actif`, `en_ligne`, `derniere_connexion`, `token_reset`, `created_at`, `updated_at`) VALUES
(1, 1, 'KAMK', 'Administrateur', 'admin@kamk.dj', '+253 21 35 00 00', '$2y$12$GdmM/kofnLBy1tuzT4G3oOiEUmveO9CtJvivHLK7W3KTq6PEhS25K', 'admin', 'KAMK-ADM-001', '2026-01-01', NULL, 'uploads/profils/photo_69b67206059ac9.84869479.jpg', 1, 0, '2026-03-22 15:39:22', NULL, '2026-03-11 20:29:45', '2026-03-22 12:39:48'),
(2, 1, 'HASSAN', 'Ali', 'contrat@kamk.dj', '+25377000010', '$2y$12$GdmM/kofnLBy1tuzT4G3oOiEUmveO9CtJvivHLK7W3KTq6PEhS25K', 'contrat', 'KAMK-CON-001', '2026-03-14', NULL, 'uploads/profils/photo_69b577f2d1c835.44479414.jpg', 1, 0, '2026-03-22 17:00:35', NULL, '2026-03-14 11:39:38', '2026-03-22 14:01:47'),
(3, 1, 'OMAR', 'Said', 'maintenance@kamk.dj', '+25377000011', '$2y$12$GdmM/kofnLBy1tuzT4G3oOiEUmveO9CtJvivHLK7W3KTq6PEhS25K', 'maintenance', 'KAMK-MAI-001', '2026-03-14', NULL, 'uploads/profils/photo_69b58a8f1a7de3.97130964.jpg', 1, 0, '2026-03-22 12:09:34', NULL, '2026-03-14 11:39:38', '2026-03-22 09:20:04');

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

DROP TABLE IF EXISTS `factures`;
CREATE TABLE IF NOT EXISTS `factures` (
  `id_facture` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_location` int UNSIGNED NOT NULL,
  `id_client` int UNSIGNED NOT NULL,
  `numero_facture` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Ex: FACT-2026-00001',
  `date_emission` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_echeance` date NOT NULL,
  `montant_ht` decimal(10,2) NOT NULL,
  `tva_taux` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Taux TVA Djibouti',
  `montant_tva` decimal(10,2) NOT NULL DEFAULT '0.00',
  `montant_ttc` decimal(10,2) NOT NULL,
  `remise` decimal(10,2) NOT NULL DEFAULT '0.00',
  `statut_paiement` enum('en_attente','partiellement_paye','paye','en_retard','annule') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en_attente',
  `pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_facture`),
  UNIQUE KEY `numero_facture` (`numero_facture`),
  KEY `id_location` (`id_location`),
  KEY `id_client` (`id_client`),
  KEY `idx_numero` (`numero_facture`),
  KEY `idx_statut` (`statut_paiement`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Factures clients';

--
-- Déchargement des données de la table `factures`
--

INSERT INTO `factures` (`id_facture`, `id_location`, `id_client`, `numero_facture`, `date_emission`, `date_echeance`, `montant_ht`, `tva_taux`, `montant_tva`, `montant_ttc`, `remise`, `statut_paiement`, `pdf_path`, `notes`, `created_at`) VALUES
(2, 1, 1, 'KAMK-F-2026-00001', '2026-03-22 11:57:49', '2026-03-29', 649.09, 10.00, 64.91, 714.00, 0.00, 'en_attente', NULL, NULL, '2026-03-22 08:57:49');

-- --------------------------------------------------------

--
-- Structure de la table `favoris_vehicules`
--

DROP TABLE IF EXISTS `favoris_vehicules`;
CREATE TABLE IF NOT EXISTS `favoris_vehicules` (
  `id_favori` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_client` int UNSIGNED NOT NULL,
  `id_vehicule` int UNSIGNED NOT NULL,
  `note` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_favori`),
  UNIQUE KEY `uk_favori` (`id_client`,`id_vehicule`),
  KEY `id_vehicule` (`id_vehicule`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `favoris_vehicules`
--

INSERT INTO `favoris_vehicules` (`id_favori`, `id_client`, `id_vehicule`, `note`, `created_at`) VALUES
(2, 1, 2, '', '2026-03-18 11:34:04'),
(4, 12, 2, '', '2026-03-22 15:20:58');

-- --------------------------------------------------------

--
-- Structure de la table `feed_chatbot`
--

DROP TABLE IF EXISTS `feed_chatbot`;
CREATE TABLE IF NOT EXISTS `feed_chatbot` (
  `id_feed` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_session` int UNSIGNED NOT NULL,
  `id_client` int UNSIGNED DEFAULT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prive` tinyint(1) NOT NULL DEFAULT '0',
  `reponse_generee` text COLLATE utf8mb4_unicode_ci,
  `date_creation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `traite` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_feed`),
  KEY `id_session` (`id_session`),
  KEY `id_client` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Questions chatbot non répondues pour amélioration';

-- --------------------------------------------------------

--
-- Structure de la table `fidelite_transactions`
--

DROP TABLE IF EXISTS `fidelite_transactions`;
CREATE TABLE IF NOT EXISTS `fidelite_transactions` (
  `id_transaction` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_client` int UNSIGNED NOT NULL,
  `id_reservation` int UNSIGNED DEFAULT NULL,
  `type_transaction` enum('gain','utilisation','expiration','bonus','correction') COLLATE utf8mb4_unicode_ci NOT NULL,
  `points` int NOT NULL COMMENT 'Positif = gain, négatif = utilisation',
  `solde_apres` int NOT NULL,
  `motif` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_le` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_transaction`),
  KEY `id_client` (`id_client`),
  KEY `id_reservation` (`id_reservation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Programme fidélité KAMK';

-- --------------------------------------------------------

--
-- Structure de la table `historique`
--

DROP TABLE IF EXISTS `historique`;
CREATE TABLE IF NOT EXISTS `historique` (
  `id_historique` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_client` int UNSIGNED DEFAULT NULL,
  `id_employe` int UNSIGNED DEFAULT NULL,
  `id_reservation` int UNSIGNED DEFAULT NULL,
  `type_action` enum('connexion','deconnexion','reservation','annulation','paiement','document','contrat','maintenance','modification','suppression','autre') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `donnees_avant` json DEFAULT NULL,
  `donnees_apres` json DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_historique`),
  KEY `id_client` (`id_client`),
  KEY `id_employe` (`id_employe`),
  KEY `id_reservation` (`id_reservation`),
  KEY `idx_action` (`type_action`),
  KEY `idx_date` (`created_at`),
  KEY `idx_historique_date` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Journal complet des actions';

--
-- Déchargement des données de la table `historique`
--

INSERT INTO `historique` (`id_historique`, `id_client`, `id_employe`, `id_reservation`, `type_action`, `description`, `donnees_avant`, `donnees_apres`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 1, NULL, NULL, '', 'Nouvelle demande d inscription client', NULL, NULL, '::1', NULL, '2026-03-13 14:52:17'),
(2, 1, NULL, NULL, '', 'Demande acompte envoyée par employé Ali', NULL, NULL, NULL, NULL, '2026-03-14 14:59:32'),
(3, 8, NULL, NULL, '', 'Nouvelle demande d inscription client', NULL, NULL, '::1', NULL, '2026-03-14 23:11:06'),
(4, 8, NULL, NULL, '', 'Demande acompte envoyée par employé Ali', NULL, NULL, NULL, NULL, '2026-03-14 23:25:00'),
(5, 9, NULL, NULL, '', 'Nouvelle demande d inscription client', NULL, NULL, '::1', NULL, '2026-03-15 10:39:32'),
(6, 10, NULL, NULL, '', 'Nouveau client à valider : Osman Marwo — Email: marwoosman11@gmail.com — Tél: 77141013', NULL, NULL, '::1', NULL, '2026-03-20 18:27:26'),
(7, 11, NULL, NULL, '', 'Nouveau client à valider : Hoch Abdirachid — Email: abdirachidhoch12@gmail.com — Tél: +25377629921', NULL, NULL, '::1', NULL, '2026-03-21 16:01:37'),
(8, 12, NULL, NULL, '', 'Nouveau client à valider : Moubarak Mr — Email: moubarekbarre@gmail.com — Tél: +25377650012', NULL, NULL, '::1', NULL, '2026-03-22 12:17:34'),
(9, NULL, 2, NULL, 'connexion', 'Connexion employé — poste : contrat', NULL, NULL, '::1', NULL, '2026-03-22 12:24:34'),
(10, NULL, 2, NULL, 'connexion', 'Connexion employé — poste : contrat', NULL, NULL, '::1', NULL, '2026-03-22 12:28:40'),
(11, NULL, 2, NULL, 'connexion', 'Connexion employé — poste : contrat', NULL, NULL, '::1', NULL, '2026-03-22 12:29:46'),
(12, NULL, 2, NULL, 'connexion', 'Connexion employé — poste : contrat', NULL, NULL, '::1', NULL, '2026-03-22 12:30:49'),
(13, NULL, 2, NULL, 'connexion', 'Connexion employé — poste : contrat', NULL, NULL, '::1', NULL, '2026-03-22 12:33:31'),
(14, NULL, 2, NULL, 'connexion', 'Connexion employé — poste : contrat', NULL, NULL, '::1', NULL, '2026-03-22 13:52:30'),
(15, NULL, 2, NULL, 'connexion', 'Connexion employé — poste : contrat', NULL, NULL, '::1', NULL, '2026-03-22 13:53:55'),
(16, NULL, 2, NULL, 'connexion', 'Connexion employé — poste : contrat', NULL, NULL, '::1', NULL, '2026-03-22 13:57:06'),
(17, NULL, 2, NULL, 'connexion', 'Connexion employé — poste : contrat', NULL, NULL, '::1', NULL, '2026-03-22 14:00:36');

-- --------------------------------------------------------

--
-- Structure de la table `historique_prix`
--

DROP TABLE IF EXISTS `historique_prix`;
CREATE TABLE IF NOT EXISTS `historique_prix` (
  `id_historique` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vehicule` int UNSIGNED NOT NULL,
  `ancien_prix` decimal(10,2) NOT NULL,
  `nouveau_prix` decimal(10,2) NOT NULL,
  `modifie_par` int UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_historique`),
  KEY `id_vehicule` (`id_vehicule`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `incidents`
--

DROP TABLE IF EXISTS `incidents`;
CREATE TABLE IF NOT EXISTS `incidents` (
  `id_incident` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vehicule` int UNSIGNED NOT NULL,
  `id_location` int UNSIGNED DEFAULT NULL,
  `id_client` int UNSIGNED DEFAULT NULL,
  `id_employe` int UNSIGNED DEFAULT NULL,
  `type_incident` enum('accident','panne','vol','vandalisme','infraction','retard','autre') COLLATE utf8mb4_unicode_ci NOT NULL,
  `gravite` enum('mineure','moderee','grave','critique') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'moderee',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lieu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `date_incident` datetime NOT NULL,
  `declare_assurance` tinyint(1) NOT NULL DEFAULT '0',
  `numero_sinistre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cout_reparation` decimal(10,2) DEFAULT '0.00',
  `cout_assurance` decimal(10,2) DEFAULT '0.00',
  `cout_client` decimal(10,2) DEFAULT '0.00' COMMENT 'Part à la charge du client',
  `statut` enum('ouvert','en_cours','resolu','clos') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ouvert',
  `resolution` text COLLATE utf8mb4_unicode_ci,
  `date_resolution` datetime DEFAULT NULL,
  `photos_path` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_incident`),
  KEY `id_vehicule` (`id_vehicule`),
  KEY `id_location` (`id_location`),
  KEY `id_client` (`id_client`),
  KEY `id_employe` (`id_employe`),
  KEY `idx_incidents_statut` (`statut`,`gravite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Incidents et gestion des risques';

-- --------------------------------------------------------

--
-- Structure de la table `inscriptions`
--

DROP TABLE IF EXISTS `inscriptions`;
CREATE TABLE IF NOT EXISTS `inscriptions` (
  `id_inscription` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_inscription` enum('client','employe') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client',
  `etape` tinyint NOT NULL DEFAULT '1' COMMENT '1=email, 2=infos, 3=docs, 4=valide',
  `token` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `donnees_temp` json DEFAULT NULL COMMENT 'Données saisies pendant inscription',
  `expire_a` datetime NOT NULL,
  `valide` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_inscription`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Processus d inscription multi-étapes';

-- --------------------------------------------------------

--
-- Structure de la table `inspections`
--

DROP TABLE IF EXISTS `inspections`;
CREATE TABLE IF NOT EXISTS `inspections` (
  `id_inspection` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vehicule` int UNSIGNED NOT NULL,
  `id_location` int UNSIGNED DEFAULT NULL,
  `id_employe` int UNSIGNED NOT NULL,
  `type_inspection` enum('depart','retour','periodique','post_accident') COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_inspection` datetime NOT NULL,
  `carrosserie_avant` tinyint(1) DEFAULT '1',
  `carrosserie_arriere` tinyint(1) DEFAULT '1',
  `carrosserie_gauche` tinyint(1) DEFAULT '1',
  `carrosserie_droite` tinyint(1) DEFAULT '1',
  `pneus_ok` tinyint(1) DEFAULT '1',
  `freins_ok` tinyint(1) DEFAULT '1',
  `phares_ok` tinyint(1) DEFAULT '1',
  `niveau_huile` enum('ok','bas','critique') COLLATE utf8mb4_unicode_ci DEFAULT 'ok',
  `niveau_carburant` tinyint UNSIGNED DEFAULT '100' COMMENT '%',
  `proprete_interieur` tinyint(1) DEFAULT '1',
  `equipements_ok` tinyint(1) DEFAULT '1',
  `photos_path` json DEFAULT NULL COMMENT 'Chemins photos inspection',
  `kilometres_releves` int UNSIGNED DEFAULT NULL,
  `observations` text COLLATE utf8mb4_unicode_ci,
  `resultat` enum('passe','echoue','a_surveiller') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'passe',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_inspection`),
  KEY `id_vehicule` (`id_vehicule`),
  KEY `id_location` (`id_location`),
  KEY `id_employe` (`id_employe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Inspections véhicules avant et après location';

-- --------------------------------------------------------

--
-- Structure de la table `intentions_chatbot`
--

DROP TABLE IF EXISTS `intentions_chatbot`;
CREATE TABLE IF NOT EXISTS `intentions_chatbot` (
  `id_intention` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mots_cles` json DEFAULT NULL,
  `reponse_type` enum('texte','redirection','formulaire','api') COLLATE utf8mb4_unicode_ci DEFAULT 'texte',
  `reponse_defaut` text COLLATE utf8mb4_unicode_ci,
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `nb_occurrences` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_intention`),
  UNIQUE KEY `nom` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Intentions reconnues par le chatbot';

--
-- Déchargement des données de la table `intentions_chatbot`
--

INSERT INTO `intentions_chatbot` (`id_intention`, `nom`, `description`, `mots_cles`, `reponse_type`, `reponse_defaut`, `actif`, `nb_occurrences`, `created_at`) VALUES
(1, 'tarifs', 'Demande de tarifs', '[\"tarif\", \"prix\", \"coût\", \"combien\"]', 'texte', 'Nos tarifs débutent à 28$/j pour les citadines.', 1, 0, '2026-03-11 20:29:45'),
(2, 'disponibilite', 'Vérification disponibilité', '[\"disponible\", \"libre\", \"réserver\"]', 'texte', 'Pour vérifier la disponibilité, rendez-vous sur notre page véhicules.', 1, 0, '2026-03-11 20:29:45'),
(3, 'reservation', 'Processus de réservation', '[\"réserver\", \"réservation\", \"louer\", \"location\"]', 'texte', 'Pour réserver, créez votre compte client puis choisissez votre véhicule.', 1, 0, '2026-03-11 20:29:45'),
(4, 'documents', 'Documents requis', '[\"document\", \"permis\", \"pièce\", \"identité\"]', 'texte', 'Il vous faut : permis valide, CNI/passeport, justificatif domicile, carte bancaire pour la caution.', 1, 0, '2026-03-11 20:29:45'),
(5, 'livraison', 'Livraison à domicile', '[\"livraison\", \"livrer\", \"domicile\", \"aéroport\"]', 'texte', 'Nous livrons dans toutes les 5 régions de Djibouti. Frais variables selon la zone.', 1, 0, '2026-03-11 20:29:45'),
(6, 'annulation', 'Politique annulation', '[\"annuler\", \"annulation\", \"remboursement\"]', 'texte', 'Annulation gratuite 24h avant. 50% remboursé jusqu à 48h avant le départ.', 1, 0, '2026-03-11 20:29:45');

-- --------------------------------------------------------

--
-- Structure de la table `liste_noire`
--

DROP TABLE IF EXISTS `liste_noire`;
CREATE TABLE IF NOT EXISTS `liste_noire` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_client` int UNSIGNED DEFAULT NULL,
  `nom_complet` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numero_permis` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `motif` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `gravite` enum('temporaire','permanent') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'temporaire',
  `date_expiration` date DEFAULT NULL COMMENT 'NULL = permanent',
  `ajoute_par` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_client` (`id_client`),
  KEY `ajoute_par` (`ajoute_par`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Clients interdits de location';

-- --------------------------------------------------------

--
-- Structure de la table `locations`
--

DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `id_location` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_reservation` int UNSIGNED NOT NULL,
  `id_vehicule` int UNSIGNED NOT NULL,
  `id_client` int UNSIGNED NOT NULL,
  `id_employe` int UNSIGNED DEFAULT NULL,
  `date_debut_reelle` datetime NOT NULL,
  `date_fin_prevue` datetime NOT NULL,
  `date_fin_reelle` datetime DEFAULT NULL,
  `km_depart` int UNSIGNED NOT NULL,
  `km_retour` int UNSIGNED DEFAULT NULL,
  `statut` enum('active','terminee','incident','retard') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `retard_jours` tinyint UNSIGNED DEFAULT '0',
  `frais_retard` decimal(8,2) DEFAULT '0.00',
  `carburant_depart` tinyint UNSIGNED DEFAULT '100' COMMENT 'Pourcentage %',
  `carburant_retour` tinyint UNSIGNED DEFAULT NULL,
  `observations` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_location`),
  UNIQUE KEY `id_reservation` (`id_reservation`),
  KEY `id_vehicule` (`id_vehicule`),
  KEY `id_client` (`id_client`),
  KEY `id_employe` (`id_employe`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Locations en cours ou terminées';

--
-- Déchargement des données de la table `locations`
--

INSERT INTO `locations` (`id_location`, `id_reservation`, `id_vehicule`, `id_client`, `id_employe`, `date_debut_reelle`, `date_fin_prevue`, `date_fin_reelle`, `km_depart`, `km_retour`, `statut`, `retard_jours`, `frais_retard`, `carburant_depart`, `carburant_retour`, `observations`, `created_at`, `updated_at`) VALUES
(1, 1, 9, 1, 2, '2026-03-17 15:36:00', '2026-03-20 15:37:00', '2026-03-22 11:57:48', 0, 0, 'terminee', 0, 0.00, 100, NULL, NULL, '2026-03-22 08:57:48', '2026-03-22 08:57:48');

-- --------------------------------------------------------

--
-- Structure de la table `logs_securite`
--

DROP TABLE IF EXISTS `logs_securite`;
CREATE TABLE IF NOT EXISTS `logs_securite` (
  `id_log` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_evenement` enum('connexion_reussie','connexion_echouee','tentative_brute_force','compte_bloque','mdp_reinitialise','token_expire','acces_non_autorise','modification_sensible','suppression') COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_client` int UNSIGNED DEFAULT NULL,
  `id_employe` int UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `risque_niveau` enum('faible','moyen','eleve','critique') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'faible',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log`),
  KEY `idx_ip` (`ip_address`),
  KEY `idx_type` (`type_evenement`),
  KEY `idx_risque` (`risque_niveau`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Journal de sécurité et tentatives d intrusion';

-- --------------------------------------------------------

--
-- Structure de la table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
CREATE TABLE IF NOT EXISTS `maintenances` (
  `id_maintenance` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vehicule` int UNSIGNED NOT NULL,
  `id_chef_maintenance` int UNSIGNED DEFAULT NULL,
  `type_maintenance` enum('revision','vidange','pneus','freins','carrosserie','panne','accident','nettoyage','autre') COLLATE utf8mb4_unicode_ci NOT NULL,
  `priorite` enum('basse','normale','haute','urgente') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normale',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `cout_prevu` decimal(10,2) DEFAULT '0.00',
  `cout_reel` decimal(10,2) DEFAULT NULL,
  `fournisseur` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Garage/prestataire',
  `date_debut` date NOT NULL,
  `date_fin_prevue` date DEFAULT NULL,
  `date_fin_reelle` date DEFAULT NULL,
  `km_au_moment` int UNSIGNED DEFAULT NULL,
  `statut` enum('planifiee','en_cours','terminee','annulee') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'planifiee',
  `rapport` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `type_declaration` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_maintenance`),
  KEY `id_vehicule` (`id_vehicule`),
  KEY `id_chef_maintenance` (`id_chef_maintenance`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Interventions de maintenance';

--
-- Déchargement des données de la table `maintenances`
--

INSERT INTO `maintenances` (`id_maintenance`, `id_vehicule`, `id_chef_maintenance`, `type_maintenance`, `priorite`, `description`, `cout_prevu`, `cout_reel`, `fournisseur`, `date_debut`, `date_fin_prevue`, `date_fin_reelle`, `km_au_moment`, `statut`, `rapport`, `created_at`, `type_declaration`) VALUES
(1, 9, 3, '', 'haute', 'Réparation post-retour client', 0.00, NULL, NULL, '2026-03-22', NULL, NULL, NULL, 'planifiee', NULL, '2026-03-22 08:15:34', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `messages_chatbot`
--

DROP TABLE IF EXISTS `messages_chatbot`;
CREATE TABLE IF NOT EXISTS `messages_chatbot` (
  `id_message` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_session` int UNSIGNED NOT NULL,
  `role` enum('user','assistant','system') COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenu` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_contenu` enum('texte','image','document','action') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'texte',
  `tokens_utilises` smallint UNSIGNED DEFAULT NULL,
  `intention_detectee` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Intention NLP détectée',
  `action_executee` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Action déclenchée',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_message`),
  KEY `idx_session` (`id_session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Messages chatbot';

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id_notification` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_client` int UNSIGNED DEFAULT NULL,
  `id_employe` int UNSIGNED DEFAULT NULL,
  `titre` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('info','succes','alerte','erreur','rappel','promo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'info',
  `canal` enum('app','email','sms','push','messagerie') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'app',
  `lue` tinyint(1) NOT NULL DEFAULT '0',
  `lien` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `envoyee` tinyint(1) NOT NULL DEFAULT '0',
  `date_envoi` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_notification`),
  KEY `id_employe` (`id_employe`),
  KEY `idx_non_lues` (`id_client`,`lue`),
  KEY `idx_notifications_canal` (`canal`,`envoyee`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Notifications in-app, email et SMS';

--
-- Déchargement des données de la table `notifications`
--

INSERT INTO `notifications` (`id_notification`, `id_client`, `id_employe`, `titre`, `message`, `type`, `canal`, `lue`, `lien`, `envoyee`, `date_envoi`, `created_at`) VALUES
(1, 1, NULL, 'Demande d\'inscription reçue', 'Bonjour Kad, votre demande a été reçue. L\'agence KAMK va vérifier votre dossier et vous envoyer vos identifiants de connexion.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-13 14:52:17'),
(2, 3, NULL, 'Bienvenue chez KAMK !', 'Compte créé avec succès !', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-13 14:58:41'),
(3, 3, NULL, 'Compte activé !', 'Bonjour Client, votre compte KAMK a été validé ! Vos identifiants vous ont été envoyés.', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-13 20:46:37'),
(4, 1, NULL, 'Compte activé !', 'Bonjour Kad, votre compte KAMK a été validé ! Vos identifiants vous ont été envoyés.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-13 20:46:46'),
(5, 1, NULL, 'Réservation envoyée !', 'Votre demande de réservation pour le Toyota Land Cruiser a été envoyée. Un employé va la traiter.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-14 12:37:50'),
(6, NULL, 2, '📋 Nouvelle réservation !', 'Kad SOULEIMAN demande le Toyota Land Cruiser du 17/03/2026 au 20/03/2026.', 'alerte', 'app', 0, 'dashboard_employe.php', 0, NULL, '2026-03-14 12:37:50'),
(7, 1, NULL, '⏰ Paiement acompte requis sous 48h', 'Bonjour Kad, votre réservation du Toyota Land Cruiser est en attente de paiement. Acompte requis : 214.2 $ (30%). Vous avez 48h pour confirmer.', 'alerte', 'app', 1, NULL, 0, NULL, '2026-03-14 14:59:24'),
(8, 1, NULL, '💳 Acompte déclaré — Kad SOULEIMAN', 'Réservation #1 — Acompte de 214.2 $ — Mode : especes — Réf : VIR-202481739', 'alerte', 'app', 1, NULL, 0, NULL, '2026-03-14 18:51:12'),
(9, 1, NULL, '💳 Acompte déclaré — Kad SOULEIMAN', 'Réservation #1 — Acompte de 214.2 $ — Mode : especes — Réf : VIR-202481739', 'alerte', 'app', 1, NULL, 0, NULL, '2026-03-14 18:51:21'),
(10, 1, NULL, '💳 Acompte déclaré — Kad SOULEIMAN', 'Réservation #1 — Acompte de 214.2 $ — Mode : cheque — Réf : VIR-20240113-52', 'alerte', 'app', 1, NULL, 0, NULL, '2026-03-14 18:53:26'),
(11, 1, NULL, '💳 Acompte déclaré — Kad SOULEIMAN', 'Réservation #1 — Acompte de 214.2 $ — Mode : cheque — Réf : VIR-20240113-52', 'alerte', 'app', 1, NULL, 0, NULL, '2026-03-14 19:05:29'),
(12, 1, NULL, '✅ Réservation confirmée !', 'Votre réservation du Toyota Land Cruiser a été confirmée. Présentez-vous à l\'agence le 17/03/2026.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-14 19:06:18'),
(13, 8, NULL, 'Demande d\'inscription reçue', 'Bonjour Ayman, votre demande a été reçue. L\'agence KAMK va vérifier votre dossier et vous envoyer vos identifiants de connexion.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-14 23:11:06'),
(14, 8, NULL, 'Compte activé !', 'Bonjour Ayman, votre compte KAMK a été validé ! Vos identifiants vous ont été envoyés.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-14 23:15:10'),
(15, 8, NULL, 'Réservation envoyée !', 'Votre demande de réservation pour le Mercedes Sprinter Cargo a été envoyée. Un employé va la traiter.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-14 23:23:37'),
(16, NULL, 2, '📋 Nouvelle réservation !', 'Ayman RAMZI demande le Mercedes Sprinter Cargo du 16/03/2026 au 18/03/2026.', 'alerte', 'app', 0, 'dashboard_employe.php', 0, NULL, '2026-03-14 23:23:37'),
(17, 8, NULL, '⏰ Paiement acompte requis sous 48h', 'Bonjour Ayman, votre réservation du Mercedes Sprinter Cargo est en attente de paiement. Acompte requis : 67.5 $ (30%). Vous avez 48h pour confirmer.', 'alerte', 'app', 0, NULL, 0, NULL, '2026-03-14 23:24:56'),
(18, 4, NULL, 'Compte activé !', 'Bonjour Kouloud, votre compte KAMK a été validé ! Vos identifiants vous ont été envoyés.', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-15 09:00:43'),
(19, 9, NULL, 'Demande d\'inscription reçue', 'Bonjour Arafo, votre demande a été reçue. L\'agence KAMK va vérifier votre dossier et vous envoyer vos identifiants de connexion.', 'info', 'app', 0, NULL, 0, NULL, '2026-03-15 10:39:32'),
(20, 9, NULL, 'Compte activé !', 'Bonjour Arafo, votre compte KAMK a été validé ! Vos identifiants vous ont été envoyés.', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-15 11:11:38'),
(21, 1, NULL, '📋 Demande de réservation reçue', 'Bonjour Kad, votre demande pour le Scott Sub Sport 20 du 15/03/2026 au 16/03/2026 est en cours de traitement. Un employé KAMK la confirmera sous 24h et vous enverra les informations de paiement.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-15 12:15:40'),
(22, NULL, 2, '📋 Nouvelle réservation à traiter', 'Kad SOULEIMAN — Scott Sub Sport 20 — du 15/03/2026 au 16/03/2026 — 26 $', 'alerte', 'app', 0, 'dashboard_employe.php?page=reservations', 0, NULL, '2026-03-15 12:15:40'),
(23, 1, NULL, '⏰ Acompte requis — 7.8 $', 'Bonjour Kad, votre réservation du Scott Sub Sport 20 nécessite un acompte de 7.8$ (30%). Connectez-vous pour payer dans les 48h.', 'alerte', 'app', 1, NULL, 0, NULL, '2026-03-15 12:30:44'),
(24, NULL, 2, '💬 Message de Kad SOULEIMAN — Sur ma reservation', 'Salam, ma demande est traiter ?', 'info', 'app', 0, 'dashboard_employe.php?page=messagerie', 0, NULL, '2026-03-16 16:38:36'),
(25, 1, NULL, '📤 Message envoyé : Sur ma reservation', 'Votre message a été transmis au service contrat. Réponse sous 24h.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-16 16:38:36'),
(26, NULL, 2, '💬 Message de Kad SOULEIMAN — Sur ma reservation', 'Salam, ma demande est traiter ?', 'info', 'app', 0, 'dashboard_employe.php?page=messagerie', 0, NULL, '2026-03-16 16:38:41'),
(27, 1, NULL, '📤 Message envoyé : Sur ma reservation', 'Votre message a été transmis au service contrat. Réponse sous 24h.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-16 16:38:41'),
(28, 1, NULL, '💰 Paiement en vérification', 'Votre paiement de 7.8$ (réf: PAY-AAF9950182) est en cours de vérification. Confirmation sous 24h.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-19 21:58:45'),
(29, NULL, 2, '💰 Nouveau paiement à valider', 'Client KAMK-00001 — 7.8$ via carte — Réf: PAY-AAF9950182', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-19 21:58:45'),
(30, 1, NULL, '💰 Paiement en vérification', 'Votre paiement de 7.8$ (réf: PAY-4AA52BDF87) est en cours de vérification. Confirmation sous 24h.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-19 21:58:52'),
(31, NULL, 2, '💰 Nouveau paiement à valider', 'Client KAMK-00001 — 7.8$ via carte — Réf: PAY-4AA52BDF87', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-19 21:58:52'),
(32, 1, NULL, '✅ Paiement confirmé !', 'Votre paiement de 7.80$ a été validé.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-19 21:59:30'),
(33, 1, NULL, '✅ Paiement confirmé !', 'Votre paiement de 7.80$ a été validé.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-19 21:59:36'),
(34, 1, NULL, '📋 Contrat prêt à signer', 'Bonjour Kad, votre contrat de location est prêt. Connectez-vous pour le signer.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-19 22:16:04'),
(35, 10, NULL, 'Demande reçue !', 'Bonjour Osman, votre dossier a été reçu. L\'administrateur KAMK va le valider et vous envoyer vos identifiants.', 'info', 'app', 0, NULL, 0, NULL, '2026-03-20 18:27:26'),
(36, 10, NULL, 'Compte activé !', 'Bonjour Osman, votre compte KAMK a été validé ! Vos identifiants vous ont été envoyés.', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-20 18:30:58'),
(37, 1, NULL, '📋 Demande de réservation reçue', 'Bonjour Kad, votre demande pour le Volkswagen Jetta du 22/03/2026 au 25/03/2026 est en cours de traitement. Un employé KAMK la confirmera sous 24h et vous enverra les informations de paiement.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-20 19:12:29'),
(38, NULL, 2, '📋 Nouvelle réservation à traiter', 'Kad SOULEIMAN — Volkswagen Jetta — du 22/03/2026 au 25/03/2026 — 195 $', 'alerte', 'app', 0, 'dashboard_employe.php?page=reservations', 0, NULL, '2026-03-20 19:12:29'),
(39, 1, NULL, '⏰ Acompte requis — 58.5 $', 'Bonjour Kad, votre réservation du Volkswagen Jetta nécessite un acompte de 58.5$ (30%). Connectez-vous pour payer dans les 48h.', 'alerte', 'app', 1, NULL, 0, NULL, '2026-03-20 19:13:25'),
(40, 1, NULL, '💰 Paiement en vérification', 'Votre paiement de 58.5$ (réf: PAY-65C0C0F9BF) est en cours de vérification. Confirmation sous 24h.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-20 19:15:11'),
(41, NULL, 2, '💰 Nouveau paiement à valider', 'Client KAMK-00001 — 58.5$ via carte — Réf: PAY-65C0C0F9BF', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-20 19:15:11'),
(42, 1, NULL, '✅ Paiement confirmé !', 'Votre paiement de 58.50$ a été validé.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-20 19:17:13'),
(43, 1, NULL, '✅ Réservation confirmée !', 'Votre Volkswagen Jetta est confirmé. Présentez-vous le 22/03/2026.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-20 19:28:14'),
(44, 1, NULL, '📋 Contrat prêt à signer', 'Bonjour Kad, votre contrat de location est prêt. Connectez-vous pour le signer.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-20 19:29:11'),
(45, 1, NULL, '💬 Réponse de l\'agence KAMK', 'hello', 'info', 'app', 1, NULL, 0, NULL, '2026-03-20 19:35:55'),
(46, NULL, 1, '💬 Message de Kad SOULEIMAN — reservation', 'il est tard', 'info', 'app', 0, 'dashboard_employe.php?page=messagerie', 0, NULL, '2026-03-20 19:36:45'),
(47, 1, NULL, '📤 Message envoyé : reservation', 'Votre message a été transmis au service admin. Réponse sous 24h.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-20 19:36:45'),
(48, 11, NULL, 'Demande reçue !', 'Bonjour Hoch, votre dossier a été reçu. L\'administrateur KAMK va le valider et vous envoyer vos identifiants.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-21 16:01:37'),
(49, 11, NULL, 'Compte activé !', 'Bonjour Hoch, votre compte KAMK a été validé ! Vos identifiants vous ont été envoyés.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-21 16:03:08'),
(50, 11, NULL, '📋 Demande de réservation reçue', 'Bonjour Hoch, votre demande pour le Skoda Superb du 22/03/2026 au 25/03/2026 est en cours de traitement. Un employé KAMK la confirmera sous 24h et vous enverra les informations de paiement.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-21 16:27:56'),
(51, NULL, 2, '📋 Nouvelle réservation à traiter', 'Hoch ABDIRACHID — Skoda Superb — du 22/03/2026 au 25/03/2026 — 375 $', 'alerte', 'app', 0, 'dashboard_employe.php?page=reservations', 0, NULL, '2026-03-21 16:27:56'),
(52, NULL, 2, '🚫 Annulation client', 'Client KAMK-00001 — Réservation #4 — Aucun remboursement', 'alerte', 'app', 0, NULL, 0, NULL, '2026-03-21 18:33:10'),
(53, 1, NULL, '🚫 Réservation annulée', 'Annulée sans remboursement selon la politique.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-21 18:33:10'),
(54, 11, NULL, '✅ Réservation confirmée !', 'Votre Skoda Superb est confirmé. Présentez-vous le 22/03/2026.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-21 19:45:04'),
(55, 11, NULL, '💰 Paiement en vérification', 'Votre paiement de 112.5$ (réf: PAY-A7E4A527E9) est en cours de vérification. Confirmation sous 24h.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-21 19:48:34'),
(56, NULL, 2, '💰 Nouveau paiement à valider', 'Client KAMK-00011 — 112.5$ via carte — Réf: PAY-A7E4A527E9', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-21 19:48:34'),
(57, NULL, 2, '🔄 Retour véhicule demandé — Kad SOULEIMAN', 'Le client KAMK-00001 souhaite restituer son véhicule. ⚠️ Retard : 30h (+320$).', 'alerte', 'app', 0, 'dashboard_employe.php?page=retour_vehicule', 0, NULL, '2026-03-21 22:29:53'),
(58, 1, NULL, '✅ Demande de retour enregistrée', 'Notre équipe va inspecter le véhicule. Vous recevrez le bilan sous peu.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-21 22:29:53'),
(59, NULL, 3, '🔧 Véhicule à inspecter — retour client', 'Merci de procéder à la vérification technique du véhicule.', 'alerte', 'app', 0, 'dashboard_employe.php?page=retour_vehicule', 0, NULL, '2026-03-21 23:17:37'),
(60, NULL, 3, '🔧 Maintenance planifiée — retour client', 'Véhicule à réparer après retour.', 'alerte', 'app', 0, 'dashboard_employe.php?page=retour_vehicule', 0, NULL, '2026-03-22 08:15:34'),
(61, 12, NULL, 'Demande reçue !', 'Bonjour Moubarak, votre dossier a été reçu. L\'administrateur KAMK va le valider et vous envoyer vos identifiants.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-22 12:17:34'),
(62, 12, NULL, 'Compte activé !', 'Bonjour Moubarak, votre compte KAMK a été validé ! Vos identifiants vous ont été envoyés.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-22 12:18:49'),
(63, 12, NULL, '📋 Demande de réservation reçue', 'Bonjour Moubarak, votre demande pour le Ford Fiesta du 22/03/2026 au 23/03/2026 est en cours de traitement. Un employé KAMK la confirmera sous 24h et vous enverra les informations de paiement.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-22 12:22:36'),
(64, NULL, 2, '📋 Nouvelle réservation à traiter', 'Moubarak MR — Ford Fiesta — du 22/03/2026 au 23/03/2026 — 55 $', 'alerte', 'app', 0, 'dashboard_employe.php?page=reservations', 0, NULL, '2026-03-22 12:22:36'),
(65, 12, NULL, '⏰ Acompte requis — 16.5 $', 'Bonjour Moubarak, votre réservation du Ford Fiesta nécessite un acompte de 16.5$ (30%). Connectez-vous pour payer dans les 48h.', 'alerte', 'app', 1, NULL, 0, NULL, '2026-03-22 12:24:55'),
(66, 12, NULL, '💰 Paiement en vérification', 'Votre paiement de 16.5$ (réf: PAY-BDBFE6CBAA) est en cours de vérification. Confirmation sous 24h.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-22 12:27:48'),
(67, NULL, 2, '💰 Nouveau paiement à valider', 'Client KAMK-00012 — 16.5$ via carte — Réf: PAY-BDBFE6CBAA', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-22 12:27:48'),
(68, 12, NULL, '✅ Paiement confirmé !', 'Votre paiement de 16.50$ a été validé par l\'agence KAMK.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-22 12:31:35'),
(69, 12, NULL, '✅ Paiement confirmé !', 'Votre paiement de 16.50$ a été validé par l\'agence KAMK.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-22 12:31:42'),
(70, 11, NULL, '✅ Paiement confirmé !', 'Votre paiement de 112.50$ a été validé par l\'agence KAMK.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-22 12:31:49'),
(71, 11, NULL, '✅ Paiement confirmé !', 'Votre paiement de 112.50$ a été validé par l\'agence KAMK.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-22 12:32:03'),
(72, 11, NULL, '📋 Demande de réservation reçue', 'Bonjour Hoch, votre demande pour le Volkswagen Jetta du 22/03/2026 au 23/03/2026 est en cours de traitement. Un employé KAMK la confirmera sous 24h et vous enverra les informations de paiement.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-22 13:52:06'),
(73, NULL, 2, '📋 Nouvelle réservation à traiter', 'Hoch ABDIRACHID — Volkswagen Jetta — du 22/03/2026 au 23/03/2026 — 60 $', 'alerte', 'app', 0, 'dashboard_employe.php?page=reservations', 0, NULL, '2026-03-22 13:52:06'),
(74, 11, NULL, '✅ Réservation confirmée !', 'Votre Volkswagen Jetta est confirmé. Présentez-vous le 22/03/2026.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-22 13:52:38'),
(75, 11, NULL, '📋 Demande de réservation reçue', 'Bonjour Hoch, votre demande pour le Cannondale Quick 4 du 23/03/2026 au 24/03/2026 est en cours de traitement. Un employé KAMK la confirmera sous 24h et vous enverra les informations de paiement.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-22 13:56:16'),
(76, NULL, 2, '📋 Nouvelle réservation à traiter', 'Hoch ABDIRACHID — Cannondale Quick 4 — du 23/03/2026 au 24/03/2026 — 26 $', 'alerte', 'app', 0, 'dashboard_employe.php?page=reservations', 0, NULL, '2026-03-22 13:56:16'),
(77, 11, NULL, '⏰ Acompte requis — 7.8 $', 'Bonjour Hoch, votre réservation du Cannondale Quick 4 nécessite un acompte de 7.8$ (30%). Connectez-vous pour payer dans les 48h.', 'alerte', 'app', 1, NULL, 0, NULL, '2026-03-22 13:57:16'),
(78, 11, NULL, '💰 Paiement en vérification', 'Votre paiement de 7.8$ (réf: PAY-3DBDDBE20E) est en cours de vérification. Confirmation sous 24h.', 'info', 'app', 1, NULL, 0, NULL, '2026-03-22 13:59:08'),
(79, NULL, 2, '💰 Nouveau paiement à valider', 'Client KAMK-00011 — 7.8$ via carte — Réf: PAY-3DBDDBE20E', 'succes', 'app', 0, NULL, 0, NULL, '2026-03-22 13:59:08'),
(80, 11, NULL, '✅ Réservation confirmée !', 'Votre Cannondale Quick 4 est confirmé. Présentez-vous le 23/03/2026.', 'succes', 'app', 1, NULL, 0, NULL, '2026-03-22 14:01:40');

-- --------------------------------------------------------

--
-- Structure de la table `options_reservation`
--

DROP TABLE IF EXISTS `options_reservation`;
CREATE TABLE IF NOT EXISTS `options_reservation` (
  `id_option` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_reservation` int UNSIGNED NOT NULL,
  `nom_option` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prix_unitaire` decimal(8,2) NOT NULL,
  `quantite` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `total` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id_option`),
  KEY `id_reservation` (`id_reservation`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `options_reservation`
--

INSERT INTO `options_reservation` (`id_option`, `id_reservation`, `nom_option`, `prix_unitaire`, `quantite`, `total`) VALUES
(1, 1, 'GPS Navigation', 5.00, 1, 15.00),
(2, 1, 'WiFi portable', 5.00, 1, 15.00),
(3, 1, 'Siège bébé', 3.00, 1, 9.00),
(4, 1, 'Assurance tous risques', 10.00, 1, 30.00),
(5, 1, 'Chauffeur inclus', 50.00, 1, 150.00),
(6, 2, 'GPS Navigation', 5.00, 1, 10.00),
(7, 2, 'WiFi portable', 5.00, 1, 10.00),
(8, 3, 'GPS Navigation', 5.00, 1, 5.00),
(9, 4, 'GPS Navigation', 5.00, 1, 15.00),
(10, 5, 'Chauffeur inclus', 50.00, 1, 150.00),
(11, 5, 'WiFi portable', 5.00, 1, 15.00),
(12, 5, 'GPS Navigation', 5.00, 1, 15.00),
(13, 6, 'WiFi portable', 5.00, 1, 5.00),
(14, 7, 'WiFi portable', 5.00, 1, 5.00),
(15, 8, 'WiFi portable', 5.00, 1, 5.00);

-- --------------------------------------------------------

--
-- Structure de la table `paiements`
--

DROP TABLE IF EXISTS `paiements`;
CREATE TABLE IF NOT EXISTS `paiements` (
  `id_paiement` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_facture` int UNSIGNED DEFAULT NULL,
  `id_reservation` int UNSIGNED DEFAULT NULL,
  `id_client` int UNSIGNED NOT NULL,
  `type_paiement` enum('caution','loyer','supplement','remboursement','penalite') COLLATE utf8mb4_unicode_ci NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `methode` enum('especes','carte_bancaire','virement','mobile_money','cheque') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_externe` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Référence banque/mobile',
  `statut` enum('en_attente','confirme','echoue','rembourse','annule') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en_attente',
  `date_paiement` datetime DEFAULT NULL,
  `recu_par` int UNSIGNED DEFAULT NULL COMMENT 'Employé qui a encaissé',
  `recu_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Scan reçu',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `statut_remboursement` enum('normal','en_cours_remboursement','rembourse') COLLATE utf8mb4_unicode_ci DEFAULT 'normal',
  PRIMARY KEY (`id_paiement`),
  KEY `id_facture` (`id_facture`),
  KEY `id_reservation` (`id_reservation`),
  KEY `id_client` (`id_client`),
  KEY `recu_par` (`recu_par`),
  KEY `idx_paiements_statut` (`statut`,`date_paiement`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Paiements et encaissements';

--
-- Déchargement des données de la table `paiements`
--

INSERT INTO `paiements` (`id_paiement`, `id_facture`, `id_reservation`, `id_client`, `type_paiement`, `montant`, `methode`, `reference_externe`, `statut`, `date_paiement`, `recu_par`, `recu_path`, `notes`, `created_at`, `statut_remboursement`) VALUES
(1, NULL, 1, 1, 'loyer', 150.00, 'carte_bancaire', 'TEST-001', 'confirme', '2026-03-19 22:04:54', NULL, NULL, NULL, '2026-03-19 19:04:54', 'normal'),
(2, NULL, 1, 1, 'loyer', 225.00, 'carte_bancaire', 'TEST-002', 'confirme', '2026-02-19 22:04:54', NULL, NULL, NULL, '2026-03-19 19:04:54', 'normal'),
(3, NULL, 1, 1, 'loyer', 80.00, 'mobile_money', 'TEST-003', 'confirme', '2026-01-19 22:04:54', NULL, NULL, NULL, '2026-03-19 19:04:54', 'normal'),
(4, NULL, 3, 1, '', 7.80, '', 'PAY-AAF9950182', 'confirme', '2026-03-20 00:58:45', NULL, NULL, NULL, '2026-03-19 21:58:45', 'normal'),
(5, NULL, 3, 1, '', 7.80, '', 'PAY-4AA52BDF87', 'confirme', '2026-03-20 00:58:52', NULL, NULL, NULL, '2026-03-19 21:58:52', 'normal'),
(6, NULL, 4, 1, '', 58.50, '', 'PAY-65C0C0F9BF', 'confirme', '2026-03-20 22:15:11', NULL, NULL, NULL, '2026-03-20 19:15:11', 'normal'),
(7, NULL, 5, 11, '', 112.50, '', 'PAY-A7E4A527E9', 'confirme', '2026-03-21 22:48:34', NULL, NULL, NULL, '2026-03-21 19:48:34', 'normal'),
(8, NULL, 6, 12, '', 16.50, '', 'PAY-BDBFE6CBAA', 'confirme', '2026-03-22 15:27:48', NULL, NULL, NULL, '2026-03-22 12:27:48', 'normal'),
(9, NULL, 8, 11, '', 7.80, '', 'PAY-3DBDDBE20E', 'en_attente', '2026-03-22 16:59:08', NULL, NULL, NULL, '2026-03-22 13:59:08', 'normal');

-- --------------------------------------------------------

--
-- Structure de la table `politiques_annulation`
--

DROP TABLE IF EXISTS `politiques_annulation`;
CREATE TABLE IF NOT EXISTS `politiques_annulation` (
  `id_politique` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `delai_gratuit_heures` int UNSIGNED NOT NULL DEFAULT '24' COMMENT 'Annulation gratuite si ≥ N heures avant',
  `remboursement_50_heures` int UNSIGNED DEFAULT '48' COMMENT 'Remboursement 50% si ≥ N heures avant',
  `remboursement_partiel_pct` decimal(5,2) DEFAULT '50.00',
  `frais_annulation_fixe` decimal(8,2) DEFAULT '0.00',
  `cas_force_majeure` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Remboursement si force majeure',
  `services_speciaux` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_politique`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Politiques d annulation';

--
-- Déchargement des données de la table `politiques_annulation`
--

INSERT INTO `politiques_annulation` (`id_politique`, `nom`, `description`, `delai_gratuit_heures`, `remboursement_50_heures`, `remboursement_partiel_pct`, `frais_annulation_fixe`, `cas_force_majeure`, `services_speciaux`, `actif`, `created_at`) VALUES
(1, 'Standard', 'Annulation gratuite 24h avant. 50% remboursé si 48h avant. Force majeure : remboursement intégral.', 24, 48, 50.00, 0.00, 1, NULL, 1, '2026-03-11 20:29:45'),
(2, 'Flexible', 'Annulation gratuite jusqu à 6h avant le départ. Aucun frais.', 6, 12, 50.00, 0.00, 1, NULL, 1, '2026-03-11 20:29:45'),
(3, 'Non remboursable', 'Tarif réduit — aucun remboursement sauf force majeure.', 0, 0, 50.00, 0.00, 1, NULL, 1, '2026-03-11 20:29:45');

-- --------------------------------------------------------

--
-- Structure de la table `politique_annulation`
--

DROP TABLE IF EXISTS `politique_annulation`;
CREATE TABLE IF NOT EXISTS `politique_annulation` (
  `id_politique` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `delai_gratuit` int DEFAULT '14' COMMENT 'Jours avant départ = 0% frais',
  `delai_25pct` int DEFAULT '7' COMMENT 'Jours avant départ = 25% frais',
  `delai_50pct` int DEFAULT '2' COMMENT 'Jours avant départ = 50% frais',
  `actif` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_politique`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `politique_annulation`
--

INSERT INTO `politique_annulation` (`id_politique`, `nom`, `description`, `delai_gratuit`, `delai_25pct`, `delai_50pct`, `actif`, `created_at`) VALUES
(1, 'Flexible', 'Annulation gratuite jusqu à 24h avant', 1, 0, 0, 1, '2026-03-15 12:58:24'),
(2, 'Standard', 'Politique standard KAMK', 14, 7, 2, 1, '2026-03-15 12:58:24'),
(3, 'Stricte', 'Frais dès la confirmation', 0, 0, 0, 1, '2026-03-15 12:58:24');

-- --------------------------------------------------------

--
-- Structure de la table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
CREATE TABLE IF NOT EXISTS `promotions` (
  `id_promo` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `code_promo` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `type_remise` enum('pourcentage','montant_fixe','jours_gratuits') COLLATE utf8mb4_unicode_ci NOT NULL,
  `valeur_remise` decimal(8,2) NOT NULL,
  `min_jours` tinyint UNSIGNED DEFAULT '1',
  `min_montant` decimal(8,2) DEFAULT '0.00',
  `categorie_vehicule` enum('personnel','familiale','entreprise','4x4','minibus','tous') COLLATE utf8mb4_unicode_ci DEFAULT 'tous',
  `usage_max` smallint UNSIGNED DEFAULT NULL COMMENT 'NULL = illimité',
  `usage_actuel` smallint UNSIGNED NOT NULL DEFAULT '0',
  `usage_par_client` tinyint UNSIGNED DEFAULT '1',
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_promo`),
  UNIQUE KEY `code_promo` (`code_promo`),
  KEY `idx_code` (`code_promo`),
  KEY `idx_validite` (`date_debut`,`date_fin`,`actif`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Codes promo et offres spéciales';

--
-- Déchargement des données de la table `promotions`
--

INSERT INTO `promotions` (`id_promo`, `code_promo`, `nom`, `description`, `type_remise`, `valeur_remise`, `min_jours`, `min_montant`, `categorie_vehicule`, `usage_max`, `usage_actuel`, `usage_par_client`, `date_debut`, `date_fin`, `actif`, `created_at`) VALUES
(1, 'KAMK2026', 'Offre Lancement', '-20% pour tout premier client', 'pourcentage', 20.00, 2, 0.00, 'tous', NULL, 0, 1, '2026-01-01', '2026-12-31', 1, '2026-03-11 20:29:45'),
(2, 'WEEKEND', 'Offre Weekend', '-15% sur les locations du vendredi au dimanche', 'pourcentage', 15.00, 2, 0.00, 'tous', NULL, 0, 1, '2026-01-01', '2026-12-31', 1, '2026-03-11 20:29:45'),
(3, 'FIDELITE10', 'Récompense Fidélité', '10$ offerts dès 100 points', 'montant_fixe', 10.00, 1, 0.00, 'tous', NULL, 0, 1, '2026-01-01', '2026-12-31', 1, '2026-03-11 20:29:45');

-- --------------------------------------------------------

--
-- Structure de la table `promotions_utilisees`
--

DROP TABLE IF EXISTS `promotions_utilisees`;
CREATE TABLE IF NOT EXISTS `promotions_utilisees` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_promo` int UNSIGNED NOT NULL,
  `id_client` int UNSIGNED NOT NULL,
  `id_reservation` int UNSIGNED NOT NULL,
  `remise_appliquee` decimal(8,2) NOT NULL,
  `date_utilisation` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_promo` (`id_promo`),
  KEY `id_client` (`id_client`),
  KEY `id_reservation` (`id_reservation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `rapports`
--

DROP TABLE IF EXISTS `rapports`;
CREATE TABLE IF NOT EXISTS `rapports` (
  `id_rapport` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_rapport` enum('journalier','hebdomadaire','mensuel','annuel','personnalise') COLLATE utf8mb4_unicode_ci NOT NULL,
  `periode_debut` date NOT NULL,
  `periode_fin` date NOT NULL,
  `nb_reservations` smallint UNSIGNED DEFAULT '0',
  `nb_annulations` smallint UNSIGNED DEFAULT '0',
  `nb_locations` smallint UNSIGNED DEFAULT '0',
  `chiffre_affaires` decimal(12,2) DEFAULT '0.00',
  `cautions_total` decimal(12,2) DEFAULT '0.00',
  `taux_occupation` decimal(5,2) DEFAULT '0.00' COMMENT '% flotte utilisée',
  `satisfaction_moy` decimal(3,2) DEFAULT NULL COMMENT 'Note moy avis',
  `vehicule_plus_loue` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zone_plus_active` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `donnees_json` json DEFAULT NULL,
  `pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genere_par` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rapport`),
  KEY `genere_par` (`genere_par`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rapports statistiques agence';

-- --------------------------------------------------------

--
-- Structure de la table `remboursements`
--

DROP TABLE IF EXISTS `remboursements`;
CREATE TABLE IF NOT EXISTS `remboursements` (
  `id_remboursement` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_paiement` int UNSIGNED NOT NULL,
  `id_client` int UNSIGNED NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `motif` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `methode_retour` enum('especes','carte_bancaire','virement','mobile_money') COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_demande` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_traitement` datetime DEFAULT NULL,
  `statut` enum('en_attente','approuve','effectue','refuse') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en_attente',
  `traite_par` int UNSIGNED DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_remboursement`),
  KEY `id_paiement` (`id_paiement`),
  KEY `id_client` (`id_client`),
  KEY `traite_par` (`traite_par`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Remboursements clients';

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE IF NOT EXISTS `reservations` (
  `id_reservation` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `reference` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Ex: KAMK-2026-00001',
  `id_client` int UNSIGNED NOT NULL,
  `id_vehicule` int UNSIGNED NOT NULL,
  `id_employe` int UNSIGNED DEFAULT NULL,
  `date_debut` datetime NOT NULL,
  `date_fin` datetime NOT NULL,
  `nb_jours` smallint UNSIGNED NOT NULL,
  `lieu_livraison` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Agence KAMK',
  `lieu_retour` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Agence KAMK',
  `zone_livraison` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Djibouti-Ville',
  `livraison_domicile` tinyint(1) NOT NULL DEFAULT '0',
  `frais_livraison` decimal(8,2) NOT NULL DEFAULT '0.00',
  `prix_jour` decimal(8,2) NOT NULL,
  `total_options` decimal(8,2) NOT NULL DEFAULT '0.00',
  `sous_total` decimal(8,2) NOT NULL,
  `remise` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT 'Remise fidélité',
  `total_ttc` decimal(8,2) NOT NULL,
  `km_depart` int UNSIGNED DEFAULT NULL,
  `km_retour` int UNSIGNED DEFAULT NULL,
  `statut` enum('en_attente','confirmee','en_cours','terminee','annulee','litige') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en_attente',
  `etape_retour` enum('non_demande','demande','inspection_contrat','inspection_maintenance','valide') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'non_demande',
  `retour_demande_at` datetime DEFAULT NULL,
  `retour_confirme_at` datetime DEFAULT NULL,
  `lieu_retour_effectif` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `retard_heures` smallint UNSIGNED DEFAULT '0',
  `frais_retard` decimal(8,2) DEFAULT '0.00',
  `frais_relocalisation` decimal(8,2) DEFAULT '0.00',
  `motif_annulation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes_client` text COLLATE utf8mb4_unicode_ci,
  `notes_employe` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `chat_history` text COLLATE utf8mb4_unicode_ci,
  `mode_remise_cle` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'physique',
  `id_politique` int UNSIGNED DEFAULT '2',
  PRIMARY KEY (`id_reservation`),
  UNIQUE KEY `reference` (`reference`),
  KEY `id_employe` (`id_employe`),
  KEY `idx_client` (`id_client`),
  KEY `idx_vehicule` (`id_vehicule`),
  KEY `idx_statut` (`statut`),
  KEY `idx_dates` (`date_debut`,`date_fin`),
  KEY `idx_reservations_dates` (`date_debut`,`date_fin`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Réservations de véhicules';

--
-- Déchargement des données de la table `reservations`
--

INSERT INTO `reservations` (`id_reservation`, `reference`, `id_client`, `id_vehicule`, `id_employe`, `date_debut`, `date_fin`, `nb_jours`, `lieu_livraison`, `lieu_retour`, `zone_livraison`, `livraison_domicile`, `frais_livraison`, `prix_jour`, `total_options`, `sous_total`, `remise`, `total_ttc`, `km_depart`, `km_retour`, `statut`, `etape_retour`, `retour_demande_at`, `retour_confirme_at`, `lieu_retour_effectif`, `retard_heures`, `frais_retard`, `frais_relocalisation`, `motif_annulation`, `notes_client`, `notes_employe`, `created_at`, `updated_at`, `chat_history`, `mode_remise_cle`, `id_politique`) VALUES
(1, 'KAMK-2026-00001', 1, 9, 2, '2026-03-17 15:36:00', '2026-03-20 15:37:00', 3, 'Agence KAMK — Djibouti-Ville', 'Agence KAMK — Djibouti-Ville', 'Djibouti-Ville', 1, 15.00, 160.00, 219.00, 480.00, 0.00, 714.00, NULL, NULL, 'terminee', 'valide', '2026-03-22 01:29:53', '2026-03-22 11:50:10', 'Agence KAMK — Djibouti-Ville', 30, 320.00, 0.00, NULL, 'De preference que vous ajouter des vehicules mariages, camion, moto', NULL, '2026-03-14 12:37:50', '2026-03-22 08:50:10', NULL, 'physique', 2),
(2, 'KAMK-2026-00002', 8, 32, NULL, '2026-03-16 06:30:00', '2026-03-18 06:30:00', 2, 'Agence KAMK — Djibouti-Ville', 'Agence KAMK — Djibouti-Ville', 'Djibouti-Ville', 1, 15.00, 95.00, 20.00, 190.00, 0.00, 225.00, NULL, NULL, 'en_attente', 'non_demande', NULL, NULL, NULL, 0, 0.00, 0.00, NULL, 'De preference que vous faites attention a l\'heure', NULL, '2026-03-14 23:23:37', '2026-03-14 23:23:37', NULL, 'physique', 2),
(3, 'KAMK-2026-00003', 1, 27, NULL, '2026-03-15 16:00:00', '2026-03-16 18:11:00', 1, 'Agence KAMK — Djibouti-Ville', 'Agence KAMK — Djibouti-Ville', 'Djibouti-Ville', 1, 15.00, 6.00, 5.00, 6.00, 0.00, 26.00, NULL, NULL, 'en_attente', 'non_demande', NULL, NULL, NULL, 0, 0.00, 0.00, NULL, 'Parfait', NULL, '2026-03-15 12:15:40', '2026-03-15 12:15:40', NULL, 'physique', 2),
(4, 'KAMK-2026-00004', 1, 4, 2, '2026-03-22 20:12:00', '2026-03-25 22:11:00', 3, 'Agence KAMK', 'Agence KAMK — Djibouti-Ville', 'Djibouti-Ville', 1, 15.00, 55.00, 15.00, 165.00, 0.00, 195.00, NULL, NULL, 'annulee', 'non_demande', NULL, NULL, NULL, 0, 0.00, 0.00, 'Changement de planning', 'Option de chauffage a ajouter', NULL, '2026-03-20 19:12:29', '2026-03-21 18:33:10', NULL, 'physique', 2),
(5, 'KAMK-2026-00005', 11, 5, 2, '2026-03-22 12:13:00', '2026-03-25 12:14:00', 3, 'Agence KAMK', 'Agence KAMK — Djibouti-Ville', 'Djibouti-Ville', 1, 15.00, 60.00, 180.00, 180.00, 0.00, 375.00, NULL, NULL, 'en_cours', 'non_demande', NULL, NULL, NULL, 0, 0.00, 0.00, NULL, 'Bonjour, je vous recommande l\'option de prendre bien soin du kilometrage illimité.', NULL, '2026-03-21 16:27:56', '2026-03-21 22:42:31', NULL, 'physique', 2),
(6, 'KAMK-2026-00006', 12, 2, NULL, '2026-03-22 16:30:00', '2026-03-23 16:30:00', 1, 'Agence KAMK', 'Agence KAMK — Djibouti-Ville', 'Djibouti-Ville', 1, 15.00, 35.00, 5.00, 35.00, 0.00, 55.00, NULL, NULL, 'en_attente', 'non_demande', NULL, NULL, NULL, 0, 0.00, 0.00, NULL, '- siege handicapé', NULL, '2026-03-22 12:22:36', '2026-03-22 12:22:36', NULL, 'physique', 2),
(7, 'KAMK-2026-00007', 11, 4, 2, '2026-03-22 20:53:00', '2026-03-23 20:53:00', 1, 'Agence KAMK', 'Agence KAMK — Djibouti-Ville', 'Djibouti-Ville', 0, 0.00, 55.00, 5.00, 55.00, 0.00, 60.00, NULL, NULL, 'confirmee', 'non_demande', NULL, NULL, NULL, 0, 0.00, 0.00, NULL, 'performance de dureé', NULL, '2026-03-22 13:52:06', '2026-03-22 13:52:38', NULL, 'physique', 2),
(8, 'KAMK-2026-00008', 11, 28, 2, '2026-03-23 16:56:00', '2026-03-24 16:56:00', 1, 'Agence KAMK', 'Agence KAMK — Djibouti-Ville', 'Djibouti-Ville', 1, 15.00, 6.00, 5.00, 6.00, 0.00, 26.00, NULL, NULL, 'confirmee', 'non_demande', NULL, NULL, NULL, 0, 0.00, 0.00, NULL, 'rfghnj', NULL, '2026-03-22 13:56:16', '2026-03-22 14:01:40', NULL, 'physique', 2);

--
-- Déclencheurs `reservations`
--
DROP TRIGGER IF EXISTS `trg_reference_reservation`;
DELIMITER $$
CREATE TRIGGER `trg_reference_reservation` BEFORE INSERT ON `reservations` FOR EACH ROW BEGIN
    IF NEW.reference IS NULL OR NEW.reference = '' THEN
        SET NEW.reference = CONCAT('KAMK-', YEAR(NOW()), '-', LPAD((SELECT COALESCE(MAX(id_reservation),0)+1 FROM reservations r2), 5, '0'));
    END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_vehicule_en_location`;
DELIMITER $$
CREATE TRIGGER `trg_vehicule_en_location` AFTER UPDATE ON `reservations` FOR EACH ROW BEGIN
    IF NEW.statut = 'en_cours' AND OLD.statut != 'en_cours' THEN
        UPDATE vehicules SET statut = 'loue' WHERE id_vehicule = NEW.id_vehicule;
    END IF;
    IF NEW.statut = 'terminee' AND OLD.statut = 'en_cours' THEN
        UPDATE vehicules SET statut = 'disponible' WHERE id_vehicule = NEW.id_vehicule;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `sauvegardes`
--

DROP TABLE IF EXISTS `sauvegardes`;
CREATE TABLE IF NOT EXISTS `sauvegardes` (
  `id_sauvegarde` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_sauvegarde` enum('complete','incrementale','reservations','clients','vehicules') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fichier_path` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `taille_mb` decimal(8,2) DEFAULT NULL,
  `statut` enum('en_cours','succes','echec') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en_cours',
  `duree_secondes` int UNSIGNED DEFAULT NULL,
  `declenche_par` int UNSIGNED DEFAULT NULL COMMENT 'id_employe ou NULL si auto',
  `message_erreur` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_sauvegarde`),
  KEY `declenche_par` (`declenche_par`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Journal des sauvegardes BDD';

-- --------------------------------------------------------

--
-- Structure de la table `sessions_chatbot`
--

DROP TABLE IF EXISTS `sessions_chatbot`;
CREATE TABLE IF NOT EXISTS `sessions_chatbot` (
  `id_session` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_client` int UNSIGNED DEFAULT NULL COMMENT 'NULL si visiteur anonyme',
  `token_session` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `canal` enum('web','mobile','whatsapp') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'web',
  `langue` enum('fr','en','ar') COLLATE utf8mb4_unicode_ci DEFAULT 'fr',
  `nb_messages` smallint UNSIGNED NOT NULL DEFAULT '0',
  `note_satisfaction` tinyint UNSIGNED DEFAULT NULL,
  `transfere_humain` tinyint(1) NOT NULL DEFAULT '0',
  `date_debut` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_fin` datetime DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_session`),
  UNIQUE KEY `token_session` (`token_session`),
  KEY `id_client` (`id_client`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `statistiques_chatbot`
--

DROP TABLE IF EXISTS `statistiques_chatbot`;
CREATE TABLE IF NOT EXISTS `statistiques_chatbot` (
  `id_stat` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `date_stat` date NOT NULL,
  `zone_horaire` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'Africa/Djibouti',
  `nb_sessions` smallint UNSIGNED NOT NULL DEFAULT '0',
  `nb_messages` int UNSIGNED NOT NULL DEFAULT '0',
  `nb_questions_sans_reponse` smallint UNSIGNED DEFAULT '0',
  `score_moyen` decimal(3,2) DEFAULT NULL,
  `questions_frequentes` json DEFAULT NULL,
  `transferts_humain` smallint UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_stat`),
  UNIQUE KEY `uk_date` (`date_stat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stats quotidiennes du chatbot';

-- --------------------------------------------------------

--
-- Structure de la table `suivi_kilometrage`
--

DROP TABLE IF EXISTS `suivi_kilometrage`;
CREATE TABLE IF NOT EXISTS `suivi_kilometrage` (
  `id_suivi` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vehicule` int UNSIGNED NOT NULL,
  `id_location` int UNSIGNED DEFAULT NULL,
  `km_debut` int UNSIGNED NOT NULL,
  `km_fin` int UNSIGNED DEFAULT NULL,
  `km_parcourus` int UNSIGNED GENERATED ALWAYS AS (if((`km_fin` is not null),(`km_fin` - `km_debut`),NULL)) STORED,
  `homologation_depart` float DEFAULT NULL COMMENT 'Litre/100km mesuré',
  `homologation_retour` float DEFAULT NULL,
  `date_debut` datetime NOT NULL,
  `date_fin` datetime DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_suivi`),
  KEY `id_vehicule` (`id_vehicule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Suivi précis du kilométrage';

-- --------------------------------------------------------

--
-- Structure de la table `tarifs`
--

DROP TABLE IF EXISTS `tarifs`;
CREATE TABLE IF NOT EXISTS `tarifs` (
  `id_tarif` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vehicule` int UNSIGNED NOT NULL,
  `type_tarif` enum('journalier','hebdomadaire','mensuel') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'journalier',
  `prix_base` decimal(8,2) NOT NULL,
  `prix_supplementaire` decimal(8,2) DEFAULT '0.00' COMMENT 'Frais km sup si dépassement',
  `caution_base` decimal(8,2) NOT NULL DEFAULT '0.00',
  `km_inclus_par_jour` int UNSIGNED DEFAULT NULL COMMENT 'NULL = illimité',
  `date_debut_validite` date NOT NULL,
  `date_fin_validite` date DEFAULT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tarif`),
  KEY `id_vehicule` (`id_vehicule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tarifs par véhicule';

-- --------------------------------------------------------

--
-- Structure de la table `vehicules`
--

DROP TABLE IF EXISTS `vehicules`;
CREATE TABLE IF NOT EXISTS `vehicules` (
  `id_vehicule` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_agence` int UNSIGNED NOT NULL,
  `marque` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modele` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `annee` year NOT NULL,
  `immatriculation` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categorie` enum('personnel','familiale','entreprise','4x4','minibus','moto','velo','camion') COLLATE utf8mb4_unicode_ci NOT NULL,
  `places` tinyint UNSIGNED NOT NULL DEFAULT '5',
  `moteur` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `carburant` enum('essence','diesel','hybride','electrique') COLLATE utf8mb4_unicode_ci DEFAULT 'diesel',
  `vitesse_max` smallint UNSIGNED DEFAULT NULL,
  `transmission` enum('manuelle','automatique') COLLATE utf8mb4_unicode_ci DEFAULT 'automatique',
  `couleur` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gps_serie` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'N° série GPS obligatoire',
  `gps_actif` tinyint(1) NOT NULL DEFAULT '1',
  `deverrouillage` enum('cle','mobile','les_deux') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cle',
  `prix_jour` decimal(8,2) NOT NULL,
  `caution_montant` decimal(8,2) NOT NULL DEFAULT '0.00',
  `kilometrage_actuel` int UNSIGNED NOT NULL DEFAULT '0',
  `seuil_revision` int UNSIGNED DEFAULT '10000' COMMENT 'Km avant prochaine révision',
  `statut` enum('disponible','loue','maintenance','hors_service','reserve') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'disponible',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `lat` decimal(10,7) DEFAULT '11.5890000',
  `lng` decimal(10,7) DEFAULT '43.1450000',
  `location` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT 'Djibouti-Ville',
  `numero_assurance` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assurance_expiry` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_vehicule`),
  UNIQUE KEY `immatriculation` (`immatriculation`),
  KEY `id_agence` (`id_agence`),
  KEY `idx_statut` (`statut`),
  KEY `idx_categorie` (`categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Flotte de véhicules KAMK';

--
-- Déchargement des données de la table `vehicules`
--

INSERT INTO `vehicules` (`id_vehicule`, `id_agence`, `marque`, `modele`, `annee`, `immatriculation`, `categorie`, `places`, `moteur`, `carburant`, `vitesse_max`, `transmission`, `couleur`, `gps_serie`, `gps_actif`, `deverrouillage`, `prix_jour`, `caution_montant`, `kilometrage_actuel`, `seuil_revision`, `statut`, `image`, `description`, `lat`, `lng`, `location`, `numero_assurance`, `assurance_expiry`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'Toyota', 'Corolla', '2022', 'DJ-001-AA', 'personnel', 5, '1.6L Essence', 'essence', 180, 'automatique', 'Blanc', 'GPS-001', 1, 'cle', 45.00, 200.00, 15000, 20000, 'disponible', 'v01_corolla.png', NULL, 11.5892000, 43.1456000, 'Djibouti-Ville, Plateau du Serpent', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-14 22:45:16'),
(2, 1, 'Ford', 'Fiesta', '2021', 'DJ-002-AA', 'personnel', 5, '1.1L Essence', 'essence', 175, 'manuelle', 'Rouge', 'GPS-002', 1, 'cle', 35.00, 150.00, 22000, 25000, 'reserve', 'v02_fiesta.png', NULL, 11.5934000, 43.1489000, 'Djibouti-Ville, Venise', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-22 12:22:36'),
(3, 1, 'Opel', 'Astra', '2021', 'DJ-003-AA', 'personnel', 5, '1.4L Turbo', 'essence', 185, 'automatique', 'Gris', 'GPS-003', 1, 'cle', 40.00, 180.00, 18000, 20000, 'disponible', 'v03_astra.png', NULL, 11.5871000, 43.1521000, 'Djibouti-Ville, Haramous', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-14 22:45:16'),
(4, 1, 'Volkswagen', 'Jetta', '2023', 'DJ-004-AA', 'personnel', 5, '1.4L TSI', 'essence', 195, 'automatique', 'Noir', 'GPS-004', 1, 'cle', 55.00, 250.00, 8000, 15000, 'reserve', 'v04_jetta.png', NULL, 11.5956000, 43.1432000, 'Djibouti-Ville, Venise', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-22 13:52:06'),
(5, 1, 'Skoda', 'Superb', '2022', 'DJ-005-AA', 'personnel', 5, '2.0L TDI', 'diesel', 200, 'automatique', 'Bleu', 'GPS-005', 1, 'cle', 60.00, 280.00, 12000, 20000, 'loue', 'v05_superb.png', NULL, 11.5883000, 43.1567000, 'Djibouti-Ville, Boulao', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-21 22:42:31'),
(6, 1, 'Toyota', 'Innova', '2023', 'DJ-008-AA', 'familiale', 7, '2.0L Diesel', 'diesel', 175, 'automatique', 'Blanc', 'GPS-008', 1, 'cle', 80.00, 350.00, 9000, 15000, 'disponible', 'v08_innova.png', NULL, 11.5842000, 43.1378000, 'Djibouti-Ville, Venise', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-14 22:45:16'),
(7, 1, 'Hyundai', 'H-1', '2022', 'DJ-009-AA', 'familiale', 9, '2.5L Diesel', 'diesel', 165, 'automatique', 'Argent', 'GPS-009', 1, 'cle', 90.00, 400.00, 14000, 20000, 'disponible', 'v09_h1.png', NULL, 11.5812000, 43.1463000, 'Djibouti-Ville, Cité Waberi', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-14 22:45:16'),
(8, 1, 'Toyota', 'Hilux', '2023', 'DJ-012-AA', '4x4', 5, '2.8L Diesel 4x4', 'diesel', 170, 'automatique', 'Blanc', 'GPS-012', 1, 'cle', 100.00, 450.00, 7000, 15000, 'disponible', 'v12_hilux.png', NULL, 11.5923000, 43.1352000, 'Djibouti-Ville, Zone Industrielle', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-14 22:45:16'),
(9, 1, 'Toyota', 'Land Cruiser', '2023', 'DJ-013-AA', '4x4', 8, '4.5L V8 Diesel', 'diesel', 200, 'automatique', 'Noir', 'GPS-013', 1, 'cle', 160.00, 700.00, 5000, 15000, 'disponible', 'v13_landcruiser.png', NULL, 11.5941000, 43.1543000, 'Djibouti-Ville, Venise', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-22 08:44:23'),
(10, 1, 'Toyota', 'HiAce 15 places', '2022', 'DJ-020-AA', 'minibus', 15, '2.7L Diesel', 'diesel', 160, 'manuelle', 'Blanc', 'GPS-020', 1, 'cle', 120.00, 500.00, 11000, 20000, 'disponible', 'v20_hiace.png', NULL, 11.5881000, 43.1412000, 'Djibouti-Ville, Venise', NULL, NULL, NULL, '2026-03-14 12:36:43', '2026-03-14 22:45:16'),
(21, 1, 'Honda', 'CB650R', '2023', 'DJ-025-AA', 'moto', 2, '649cc 4 cylindres', 'essence', 190, 'manuelle', 'Noir', 'GPS-025', 1, 'cle', 28.00, 120.00, 5000, 10000, 'disponible', 'v25_moto3.png', NULL, 11.5901000, 43.1445000, 'Djibouti-Ville, Centre', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:16'),
(22, 1, 'Kawasaki', 'Z400', '2023', 'DJ-026-AA', 'moto', 2, '399cc Bicylindre', 'essence', 175, 'manuelle', 'Vert', 'GPS-026', 1, 'cle', 22.00, 100.00, 3000, 10000, 'disponible', 'v26_moto4.png', NULL, 11.5867000, 43.1398000, 'Djibouti-Ville, Plateau du Serpent', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:16'),
(23, 1, 'Suzuki', 'GSX-S750', '2022', 'DJ-027-AA', 'moto', 2, '749cc 4 cylindres', 'essence', 210, 'manuelle', 'Bleu', 'GPS-027', 1, 'cle', 32.00, 140.00, 8000, 15000, 'disponible', 'v27_moto5.png', NULL, 11.5945000, 43.1478000, 'Djibouti-Ville, Haramous', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:16'),
(24, 1, 'BMW', 'G310R', '2023', 'DJ-028-AA', 'moto', 2, '313cc Monocylindre', 'essence', 160, 'manuelle', 'Blanc', 'GPS-028', 1, 'cle', 20.00, 90.00, 2000, 10000, 'disponible', 'v28_moto6.png', NULL, 11.5878000, 43.1534000, 'Djibouti-Ville, PK12', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:16'),
(25, 1, 'Decathlon', 'E-City 500', '2023', 'DJ-029-AA', 'velo', 1, 'Moteur électrique 250W', 'electrique', 25, 'automatique', 'Blanc', 'GPS-029', 1, 'cle', 12.00, 50.00, 500, 5000, 'disponible', 'v29_velo3.png', NULL, 11.5912000, 43.1423000, 'Djibouti-Ville, Venise', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:16'),
(26, 1, 'Specialized', 'Sirrus X', '2023', 'DJ-030-AA', 'velo', 1, 'Vélo fitness', 'essence', 30, 'manuelle', 'Beige', 'GPS-030', 1, 'cle', 7.00, 30.00, 200, 3000, 'disponible', 'v30_velo4.png', NULL, 11.5834000, 43.1467000, 'Djibouti-Ville, Harbour', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:16'),
(27, 1, 'Scott', 'Sub Sport 20', '2022', 'DJ-031-AA', 'velo', 1, 'Vélo urbain', 'essence', 28, 'manuelle', 'Noir', 'GPS-031', 1, 'cle', 6.00, 25.00, 300, 3000, 'reserve', 'v31_velo5.png', NULL, 11.5967000, 43.1389000, 'Djibouti-Ville, Balbala', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-15 12:15:40'),
(28, 1, 'Cannondale', 'Quick 4', '2022', 'DJ-032-AA', 'velo', 1, 'Vélo polyvalent', 'essence', 30, 'manuelle', 'Bleu', 'GPS-032', 1, 'cle', 6.00, 25.00, 150, 3000, 'reserve', 'v32_velo6.png', NULL, 11.5856000, 43.1512000, 'Djibouti-Ville, Ambouli', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-22 13:56:16'),
(29, 1, 'Toyota', 'Dyna', '2022', 'DJ-033-AA', 'camion', 3, '3.0L Diesel', 'diesel', 120, 'manuelle', 'Blanc', 'GPS-033', 1, 'cle', 80.00, 400.00, 25000, 30000, 'disponible', 'v33_camion1.png', NULL, 11.5923000, 43.1312000, 'Djibouti-Ville, Zone Industrielle', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:17'),
(30, 1, 'Mitsubishi', 'Canter', '2022', 'DJ-034-AA', 'camion', 3, '3.0L Diesel', 'diesel', 115, 'manuelle', 'Gris', 'GPS-034', 1, 'cle', 90.00, 450.00, 30000, 35000, 'disponible', 'v34_camion2.png', NULL, 11.5834000, 43.1289000, 'Djibouti-Ville, Zone Industrielle', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:17'),
(31, 1, 'Isuzu', 'NPR', '2023', 'DJ-035-AA', 'camion', 3, '3.0L Diesel', 'diesel', 110, 'manuelle', 'Blanc', 'GPS-035', 1, 'cle', 85.00, 420.00, 18000, 30000, 'disponible', 'v35_camion3.png', NULL, 11.5901000, 43.1267000, 'Djibouti-Ville, Zone Portuaire', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:17'),
(32, 1, 'Mercedes', 'Sprinter Cargo', '2023', 'DJ-036-AA', 'camion', 3, '2.2L Diesel', 'diesel', 130, 'manuelle', 'Blanc', 'GPS-036', 1, 'cle', 95.00, 480.00, 12000, 25000, 'reserve', 'v36_camion4.png', NULL, 11.5867000, 43.1334000, 'Djibouti-Ville, Zone Industrielle', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 23:23:37'),
(33, 1, 'Ford', 'Transit Cargo', '2022', 'DJ-037-AA', 'camion', 3, '2.0L Diesel', 'diesel', 125, 'manuelle', 'Blanc', 'GPS-037', 1, 'cle', 88.00, 440.00, 20000, 30000, 'disponible', 'v37_camion5.png', NULL, 11.5845000, 43.1356000, 'Djibouti-Ville, PK12', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:17'),
(34, 1, 'Renault', 'Master', '2023', 'DJ-038-AA', 'camion', 3, '2.3L Diesel', 'diesel', 120, 'manuelle', 'Blanc', 'GPS-038', 1, 'cle', 82.00, 410.00, 15000, 28000, 'disponible', 'v38_camion6.png', NULL, 11.5912000, 43.1298000, 'Djibouti-Ville, Zone Portuaire', NULL, NULL, NULL, '2026-03-14 22:37:37', '2026-03-14 22:45:17'),
(35, 1, 'D12JAI', 'Camion12', '2024', 'DJ-001-27', 'camion', 3, '3.0L Diesel', 'diesel', 120, 'manuelle', 'Blanc', '', 1, 'cle', 85.00, 400.00, 0, 20000, 'disponible', 'v_d12jaicamion12_1773585568.png', NULL, 11.5892000, 43.1456000, 'Djibouti-Ville', NULL, NULL, NULL, '2026-03-15 14:39:28', '2026-03-15 14:39:28');

-- --------------------------------------------------------

--
-- Structure de la table `vehicule_positions`
--

DROP TABLE IF EXISTS `vehicule_positions`;
CREATE TABLE IF NOT EXISTS `vehicule_positions` (
  `id_position` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vehicule` int UNSIGNED NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `vitesse` smallint UNSIGNED DEFAULT '0' COMMENT 'km/h',
  `cap` smallint UNSIGNED DEFAULT '0' COMMENT '0-360 degrés',
  `altitude` smallint DEFAULT '0' COMMENT 'mètres',
  `signal_gps` tinyint UNSIGNED DEFAULT '100' COMMENT '0-100%',
  `carburant_niveau` tinyint UNSIGNED DEFAULT NULL COMMENT '0-100%',
  `moteur_allume` tinyint(1) DEFAULT '0',
  `recorded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_position`),
  KEY `idx_vehicule_time` (`id_vehicule`,`recorded_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Positions GPS temps réel';

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_gps_derniere_position`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_gps_derniere_position`;
CREATE TABLE IF NOT EXISTS `v_gps_derniere_position` (
`carburant_niveau` tinyint unsigned
,`derniere_maj` timestamp
,`id_vehicule` int unsigned
,`immatriculation` varchar(30)
,`latitude` decimal(10,7)
,`longitude` decimal(10,7)
,`marque` varchar(100)
,`modele` varchar(100)
,`statut` enum('disponible','loue','maintenance','hors_service','reserve')
,`vitesse` smallint unsigned
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_kpi_jour`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_kpi_jour`;
CREATE TABLE IF NOT EXISTS `v_kpi_jour` (
`alertes_non_traitees` bigint
,`ca_aujourd_hui` decimal(32,2)
,`locations_en_cours` bigint
,`nouveaux_clients` bigint
,`reservations_aujourd_hui` bigint
,`vehicules_disponibles` bigint
,`vehicules_maintenance` bigint
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_reservations_actives`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_reservations_actives`;
CREATE TABLE IF NOT EXISTS `v_reservations_actives` (
`client` varchar(201)
,`date_debut` datetime
,`date_fin` datetime
,`id_reservation` int unsigned
,`immatriculation` varchar(30)
,`nb_jours` smallint unsigned
,`reference` varchar(25)
,`statut` enum('en_attente','confirmee','en_cours','terminee','annulee','litige')
,`tel_client` varchar(30)
,`total_ttc` decimal(8,2)
,`vehicule` varchar(201)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_vehicules_disponibles`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_vehicules_disponibles`;
CREATE TABLE IF NOT EXISTS `v_vehicules_disponibles` (
`annee` year
,`categorie` enum('personnel','familiale','entreprise','4x4','minibus','moto','velo','camion')
,`caution_montant` decimal(8,2)
,`deverrouillage` enum('cle','mobile','les_deux')
,`gps_actif` tinyint(1)
,`id_vehicule` int unsigned
,`image` varchar(255)
,`marque` varchar(100)
,`modele` varchar(100)
,`places` tinyint unsigned
,`prix_jour` decimal(8,2)
,`ville_agence` varchar(100)
);

-- --------------------------------------------------------

--
-- Structure de la vue `v_gps_derniere_position`
--
DROP TABLE IF EXISTS `v_gps_derniere_position`;

DROP VIEW IF EXISTS `v_gps_derniere_position`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_gps_derniere_position`  AS SELECT `v`.`id_vehicule` AS `id_vehicule`, `v`.`marque` AS `marque`, `v`.`modele` AS `modele`, `v`.`immatriculation` AS `immatriculation`, `v`.`statut` AS `statut`, `p`.`latitude` AS `latitude`, `p`.`longitude` AS `longitude`, `p`.`vitesse` AS `vitesse`, `p`.`carburant_niveau` AS `carburant_niveau`, `p`.`recorded_at` AS `derniere_maj` FROM (`vehicules` `v` left join `vehicule_positions` `p` on((`p`.`id_position` = (select max(`p2`.`id_position`) from `vehicule_positions` `p2` where (`p2`.`id_vehicule` = `v`.`id_vehicule`))))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `v_kpi_jour`
--
DROP TABLE IF EXISTS `v_kpi_jour`;

DROP VIEW IF EXISTS `v_kpi_jour`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_kpi_jour`  AS SELECT (select count(0) from `reservations` where (cast(`reservations`.`created_at` as date) = curdate())) AS `reservations_aujourd_hui`, (select count(0) from `locations` where (`locations`.`statut` = 'active')) AS `locations_en_cours`, (select count(0) from `vehicules` where (`vehicules`.`statut` = 'disponible')) AS `vehicules_disponibles`, (select count(0) from `vehicules` where (`vehicules`.`statut` = 'maintenance')) AS `vehicules_maintenance`, (select coalesce(sum(`paiements`.`montant`),0) from `paiements` where ((cast(`paiements`.`date_paiement` as date) = curdate()) and (`paiements`.`statut` = 'confirme'))) AS `ca_aujourd_hui`, (select count(0) from `alertes_systeme` where (`alertes_systeme`.`traitee` = 0)) AS `alertes_non_traitees`, (select count(0) from `clients` where (cast(`clients`.`created_at` as date) = curdate())) AS `nouveaux_clients` ;

-- --------------------------------------------------------

--
-- Structure de la vue `v_reservations_actives`
--
DROP TABLE IF EXISTS `v_reservations_actives`;

DROP VIEW IF EXISTS `v_reservations_actives`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_reservations_actives`  AS SELECT `r`.`id_reservation` AS `id_reservation`, `r`.`reference` AS `reference`, `r`.`statut` AS `statut`, concat(`c`.`prenom`,' ',`c`.`nom`) AS `client`, `c`.`telephone` AS `tel_client`, concat(`v`.`marque`,' ',`v`.`modele`) AS `vehicule`, `v`.`immatriculation` AS `immatriculation`, `r`.`date_debut` AS `date_debut`, `r`.`date_fin` AS `date_fin`, `r`.`nb_jours` AS `nb_jours`, `r`.`total_ttc` AS `total_ttc` FROM ((`reservations` `r` join `clients` `c` on((`r`.`id_client` = `c`.`id_client`))) join `vehicules` `v` on((`r`.`id_vehicule` = `v`.`id_vehicule`))) WHERE (`r`.`statut` in ('confirmee','en_cours')) ;

-- --------------------------------------------------------

--
-- Structure de la vue `v_vehicules_disponibles`
--
DROP TABLE IF EXISTS `v_vehicules_disponibles`;

DROP VIEW IF EXISTS `v_vehicules_disponibles`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_vehicules_disponibles`  AS SELECT `v`.`id_vehicule` AS `id_vehicule`, `v`.`marque` AS `marque`, `v`.`modele` AS `modele`, `v`.`annee` AS `annee`, `v`.`categorie` AS `categorie`, `v`.`prix_jour` AS `prix_jour`, `v`.`caution_montant` AS `caution_montant`, `v`.`places` AS `places`, `v`.`image` AS `image`, `v`.`deverrouillage` AS `deverrouillage`, `v`.`gps_actif` AS `gps_actif`, `a`.`ville` AS `ville_agence` FROM (`vehicules` `v` join `agences` `a` on((`v`.`id_agence` = `a`.`id_agence`))) WHERE ((`v`.`statut` = 'disponible') AND (`v`.`gps_actif` = 1)) ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `annotations`
--
ALTER TABLE `annotations`
  ADD CONSTRAINT `annotations_ibfk_1` FOREIGN KEY (`id_employe`) REFERENCES `employes` (`id_employe`),
  ADD CONSTRAINT `annotations_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE CASCADE,
  ADD CONSTRAINT `annotations_ibfk_3` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`) ON DELETE CASCADE,
  ADD CONSTRAINT `annotations_ibfk_4` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`) ON DELETE CASCADE;

--
-- Contraintes pour la table `assurances`
--
ALTER TABLE `assurances`
  ADD CONSTRAINT `assurances_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`) ON DELETE CASCADE;

--
-- Contraintes pour la table `avis_clients`
--
ALTER TABLE `avis_clients`
  ADD CONSTRAINT `avis_clients_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE CASCADE,
  ADD CONSTRAINT `avis_clients_ibfk_2` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`) ON DELETE CASCADE,
  ADD CONSTRAINT `avis_clients_ibfk_3` FOREIGN KEY (`repondu_par`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `capacites`
--
ALTER TABLE `capacites`
  ADD CONSTRAINT `capacites_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cautions`
--
ALTER TABLE `cautions`
  ADD CONSTRAINT `cautions_ibfk_1` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`),
  ADD CONSTRAINT `cautions_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  ADD CONSTRAINT `cautions_ibfk_3` FOREIGN KEY (`libere_par`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `contrats`
--
ALTER TABLE `contrats`
  ADD CONSTRAINT `contrats_ibfk_1` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`),
  ADD CONSTRAINT `contrats_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  ADD CONSTRAINT `contrats_ibfk_3` FOREIGN KEY (`id_employe`) REFERENCES `employes` (`id_employe`);

--
-- Contraintes pour la table `documents_client`
--
ALTER TABLE `documents_client`
  ADD CONSTRAINT `documents_client_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE CASCADE,
  ADD CONSTRAINT `documents_client_ibfk_2` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`) ON DELETE SET NULL,
  ADD CONSTRAINT `documents_client_ibfk_3` FOREIGN KEY (`valide_par`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `employes`
--
ALTER TABLE `employes`
  ADD CONSTRAINT `employes_ibfk_1` FOREIGN KEY (`id_agence`) REFERENCES `agences` (`id_agence`) ON DELETE RESTRICT;

--
-- Contraintes pour la table `factures`
--
ALTER TABLE `factures`
  ADD CONSTRAINT `factures_ibfk_1` FOREIGN KEY (`id_location`) REFERENCES `locations` (`id_location`),
  ADD CONSTRAINT `factures_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`);

--
-- Contraintes pour la table `feed_chatbot`
--
ALTER TABLE `feed_chatbot`
  ADD CONSTRAINT `feed_chatbot_ibfk_1` FOREIGN KEY (`id_session`) REFERENCES `sessions_chatbot` (`id_session`),
  ADD CONSTRAINT `feed_chatbot_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE SET NULL;

--
-- Contraintes pour la table `fidelite_transactions`
--
ALTER TABLE `fidelite_transactions`
  ADD CONSTRAINT `fidelite_transactions_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE CASCADE,
  ADD CONSTRAINT `fidelite_transactions_ibfk_2` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`) ON DELETE SET NULL;

--
-- Contraintes pour la table `historique`
--
ALTER TABLE `historique`
  ADD CONSTRAINT `historique_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE SET NULL,
  ADD CONSTRAINT `historique_ibfk_2` FOREIGN KEY (`id_employe`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL,
  ADD CONSTRAINT `historique_ibfk_3` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`) ON DELETE SET NULL;

--
-- Contraintes pour la table `incidents`
--
ALTER TABLE `incidents`
  ADD CONSTRAINT `incidents_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`),
  ADD CONSTRAINT `incidents_ibfk_2` FOREIGN KEY (`id_location`) REFERENCES `locations` (`id_location`) ON DELETE SET NULL,
  ADD CONSTRAINT `incidents_ibfk_3` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE SET NULL,
  ADD CONSTRAINT `incidents_ibfk_4` FOREIGN KEY (`id_employe`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `inspections`
--
ALTER TABLE `inspections`
  ADD CONSTRAINT `inspections_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`) ON DELETE CASCADE,
  ADD CONSTRAINT `inspections_ibfk_2` FOREIGN KEY (`id_location`) REFERENCES `locations` (`id_location`) ON DELETE SET NULL,
  ADD CONSTRAINT `inspections_ibfk_3` FOREIGN KEY (`id_employe`) REFERENCES `employes` (`id_employe`);

--
-- Contraintes pour la table `liste_noire`
--
ALTER TABLE `liste_noire`
  ADD CONSTRAINT `liste_noire_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE SET NULL,
  ADD CONSTRAINT `liste_noire_ibfk_2` FOREIGN KEY (`ajoute_par`) REFERENCES `employes` (`id_employe`);

--
-- Contraintes pour la table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`),
  ADD CONSTRAINT `locations_ibfk_2` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`),
  ADD CONSTRAINT `locations_ibfk_3` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  ADD CONSTRAINT `locations_ibfk_4` FOREIGN KEY (`id_employe`) REFERENCES `employes` (`id_employe`);

--
-- Contraintes pour la table `maintenances`
--
ALTER TABLE `maintenances`
  ADD CONSTRAINT `maintenances_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`) ON DELETE CASCADE,
  ADD CONSTRAINT `maintenances_ibfk_2` FOREIGN KEY (`id_chef_maintenance`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `messages_chatbot`
--
ALTER TABLE `messages_chatbot`
  ADD CONSTRAINT `messages_chatbot_ibfk_1` FOREIGN KEY (`id_session`) REFERENCES `sessions_chatbot` (`id_session`) ON DELETE CASCADE;

--
-- Contraintes pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`id_employe`) REFERENCES `employes` (`id_employe`) ON DELETE CASCADE;

--
-- Contraintes pour la table `options_reservation`
--
ALTER TABLE `options_reservation`
  ADD CONSTRAINT `options_reservation_ibfk_1` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`) ON DELETE CASCADE;

--
-- Contraintes pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD CONSTRAINT `paiements_ibfk_1` FOREIGN KEY (`id_facture`) REFERENCES `factures` (`id_facture`) ON DELETE SET NULL,
  ADD CONSTRAINT `paiements_ibfk_2` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`) ON DELETE SET NULL,
  ADD CONSTRAINT `paiements_ibfk_3` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  ADD CONSTRAINT `paiements_ibfk_4` FOREIGN KEY (`recu_par`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `promotions_utilisees`
--
ALTER TABLE `promotions_utilisees`
  ADD CONSTRAINT `promotions_utilisees_ibfk_1` FOREIGN KEY (`id_promo`) REFERENCES `promotions` (`id_promo`),
  ADD CONSTRAINT `promotions_utilisees_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  ADD CONSTRAINT `promotions_utilisees_ibfk_3` FOREIGN KEY (`id_reservation`) REFERENCES `reservations` (`id_reservation`);

--
-- Contraintes pour la table `rapports`
--
ALTER TABLE `rapports`
  ADD CONSTRAINT `rapports_ibfk_1` FOREIGN KEY (`genere_par`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `remboursements`
--
ALTER TABLE `remboursements`
  ADD CONSTRAINT `remboursements_ibfk_1` FOREIGN KEY (`id_paiement`) REFERENCES `paiements` (`id_paiement`),
  ADD CONSTRAINT `remboursements_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  ADD CONSTRAINT `remboursements_ibfk_3` FOREIGN KEY (`traite_par`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE RESTRICT,
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`) ON DELETE RESTRICT,
  ADD CONSTRAINT `reservations_ibfk_3` FOREIGN KEY (`id_employe`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `sauvegardes`
--
ALTER TABLE `sauvegardes`
  ADD CONSTRAINT `sauvegardes_ibfk_1` FOREIGN KEY (`declenche_par`) REFERENCES `employes` (`id_employe`) ON DELETE SET NULL;

--
-- Contraintes pour la table `sessions_chatbot`
--
ALTER TABLE `sessions_chatbot`
  ADD CONSTRAINT `sessions_chatbot_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE SET NULL;

--
-- Contraintes pour la table `suivi_kilometrage`
--
ALTER TABLE `suivi_kilometrage`
  ADD CONSTRAINT `suivi_kilometrage_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tarifs`
--
ALTER TABLE `tarifs`
  ADD CONSTRAINT `tarifs_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`) ON DELETE CASCADE;

--
-- Contraintes pour la table `vehicules`
--
ALTER TABLE `vehicules`
  ADD CONSTRAINT `vehicules_ibfk_1` FOREIGN KEY (`id_agence`) REFERENCES `agences` (`id_agence`);

--
-- Contraintes pour la table `vehicule_positions`
--
ALTER TABLE `vehicule_positions`
  ADD CONSTRAINT `vehicule_positions_ibfk_1` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicules` (`id_vehicule`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
