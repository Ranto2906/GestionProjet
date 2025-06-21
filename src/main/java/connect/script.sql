-- Active: 1750359850852@@127.0.0.1@3306@piciculture
-- Create database and tables
CREATE DATABASE IF NOT EXISTS piciculture;
USE piciculture;

-- Table utilisateurs
CREATE TABLE utilisateurs(
   user_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   email VARCHAR(100) UNIQUE,
   mot_de_passe VARCHAR(255) NOT NULL,
   role ENUM('admin', 'technicien', 'observateur') NOT NULL DEFAULT 'technicien',
   date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   date_mise_a_jour DATETIME ON UPDATE CURRENT_TIMESTAMP,
   actif BOOLEAN NOT NULL DEFAULT TRUE,
   PRIMARY KEY(user_id)
);

-- Table especes_poissons
CREATE TABLE especes_poissons(
   espece_id INT AUTO_INCREMENT,
   nom_scientifique VARCHAR(100) NOT NULL,
   nom_commun VARCHAR(50) NOT NULL,
   temperature_optimale_min DECIMAL(5,2),
   temperature_optimale_max DECIMAL(5,2),
   ph_optimal_min DECIMAL(4,2),
   ph_optimal_max DECIMAL(4,2),
   PRIMARY KEY(espece_id),
   UNIQUE(nom_scientifique)
);

-- Table types_bassin
CREATE TABLE types_bassin (
   type_bassin_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   description TEXT,
   date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   date_mise_a_jour DATETIME ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY(type_bassin_id),
   UNIQUE(nom)
);

-- Table types_aliment
CREATE TABLE types_aliment(
   typeAliment_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   description TEXT,
   composition TEXT,
   taille_granulometrie VARCHAR(20),
   pourcentage_proteines DECIMAL(5,2),
   PRIMARY KEY(typeAliment_id)
);

-- Table fournisseurs
CREATE TABLE fournisseurs(
   fournisseur_id INT AUTO_INCREMENT,
   nom VARCHAR(100) NOT NULL,
   contact VARCHAR(100),
   telephone VARCHAR(20),
   email VARCHAR(100),
   adresse TEXT,
   specialite VARCHAR(100),
   date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   date_mise_a_jour DATETIME ON UPDATE CURRENT_TIMESTAMP,
   actif BOOLEAN NOT NULL DEFAULT TRUE,
   PRIMARY KEY(fournisseur_id)
);

-- Table lots_poissons
CREATE TABLE lots_poissons(
   lots_id INT AUTO_INCREMENT,
   espece_id INT NOT NULL,
   date_introduction DATETIME NOT NULL,
   nombre_initial INT NOT NULL,
   poids_moyen_initial_g DECIMAL(10,2) NOT NULL,
   provenance VARCHAR(100),
   date_recolte_prevue DATE,
   statut ENUM('actif', 'recolte', 'mortalite', 'transfere') NOT NULL DEFAULT 'actif',
   commentaires TEXT,
   date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   date_mise_a_jour DATETIME ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY(lots_id),
   FOREIGN KEY(espece_id) REFERENCES especes_poissons(espece_id),
   INDEX idx_statut (statut)
);

-- Table bassins
CREATE TABLE bassins(
    bassin_id INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
   statut ENUM('actif', 'maintenance', 'vide') NOT NULL DEFAULT 'actif',
    capacite_m3 DECIMAL(10,2) NOT NULL,
    type_bassin_id INT NOT NULL,
    date_mise_en_service DATE,
    description TEXT,
    localisation VARCHAR(100),
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_mise_a_jour DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(bassin_id),
    FOREIGN KEY(type_bassin_id) REFERENCES types_bassin(type_bassin_id)
);

-- Table de liaison bassin_lots
CREATE TABLE bassin_lots (
    bassin_id INT NOT NULL,
    lots_id INT NOT NULL,
    date_debut DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_fin DATETIME,
    PRIMARY KEY (bassin_id, lots_id, date_debut),
    FOREIGN KEY (bassin_id) REFERENCES bassins(bassin_id),
    FOREIGN KEY (lots_id) REFERENCES lots_poissons(lots_id)
);

-- Table stocks_nourriture
CREATE TABLE stocks_nourriture(
   stock_id INT AUTO_INCREMENT,
   typeAliment_id INT NOT NULL,
   quantite_kg DECIMAL(10,2) NOT NULL,
   date_reception DATETIME NOT NULL,
   date_peremption DATE,
   prix_unitaire DECIMAL(10,2) NOT NULL,
   numero_lot VARCHAR(50),
   conditions_stockage VARCHAR(100),
   date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   date_mise_a_jour DATETIME ON UPDATE CURRENT_TIMESTAMP,
   fournisseur_id INT,
   PRIMARY KEY(stock_id),
   FOREIGN KEY(typeAliment_id) REFERENCES types_aliment(typeAliment_id),
   FOREIGN KEY(fournisseur_id) REFERENCES fournisseurs(fournisseur_id),
   INDEX idx_peremption (date_peremption)
);

-- Table especes_aliments
CREATE TABLE especes_aliments (
    espece_id INT NOT NULL,
    typeAliment_id INT NOT NULL,
    preference TINYINT DEFAULT 1,
    PRIMARY KEY(espece_id, typeAliment_id),
    FOREIGN KEY(espece_id) REFERENCES especes_poissons(espece_id),
    FOREIGN KEY(typeAliment_id) REFERENCES types_aliment(typeAliment_id)
);

-- Table suivi_quotidien
CREATE TABLE suivi_quotidien(
   suivi_id INT AUTO_INCREMENT,
   date_observation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   temperature_eau DECIMAL(5,2),
   ph DECIMAL(4,2),
   oxygene_dissous_mgL DECIMAL(5,2),
   mortalite_nombre INT DEFAULT 0,
   poids_moyen_g DECIMAL(10,2),
   quantite_aliment_g DECIMAL(10,2),
   type_aliment_id INT,
   observations TEXT,
   date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   date_mise_a_jour DATETIME ON UPDATE CURRENT_TIMESTAMP,
   user_id INT NOT NULL,
   lots_id INT NOT NULL,
   bassin_id INT NOT NULL,
   PRIMARY KEY(suivi_id),
   FOREIGN KEY(user_id) REFERENCES utilisateurs(user_id),
   FOREIGN KEY(lots_id) REFERENCES lots_poissons(lots_id),
   FOREIGN KEY(type_aliment_id) REFERENCES types_aliment(typeAliment_id),
   FOREIGN KEY(bassin_id) REFERENCES bassins(bassin_id),
   INDEX idx_date (date_observation),
   INDEX idx_lots (lots_id)
);

-- Table types_operation
CREATE TABLE types_operation(
   type_operation_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   description TEXT,
   PRIMARY KEY(type_operation_id)
);

-- Table operations
CREATE TABLE operations(
   operation_id INT AUTO_INCREMENT,
   type_operation_id INT NOT NULL,
   bassin_id INT,
   date_operation DATETIME NOT NULL,
   description TEXT,
   produits_utilises TEXT,
   cout DECIMAL(10,2),
   duree_minutes INT,
   date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   date_mise_a_jour DATETIME ON UPDATE CURRENT_TIMESTAMP,
   user_id INT NOT NULL,
   lots_id INT,
   PRIMARY KEY(operation_id),
   FOREIGN KEY(user_id) REFERENCES utilisateurs(user_id),
   FOREIGN KEY(bassin_id) REFERENCES bassins(bassin_id),
   FOREIGN KEY(lots_id) REFERENCES lots_poissons(lots_id),
   FOREIGN KEY(type_operation_id) REFERENCES types_operation(type_operation_id),
   INDEX idx_date (date_operation)
);

-- Table alertes
CREATE TABLE alertes(
   alerte_id INT AUTO_INCREMENT,
   type ENUM('temperature', 'ph', 'oxygene', 'mortalite', 'nourriture', 'maintenance', 'qualite_eau') NOT NULL,
   niveau ENUM('info', 'avertissement', 'urgence') NOT NULL,
   description TEXT NOT NULL,
   parametres JSON,
   date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   date_resolution DATETIME,
   resolue BOOLEAN NOT NULL DEFAULT FALSE,
   user_id_creation INT,
   user_id_resolution INT,
   bassin_id INT,
   lots_id INT,
   PRIMARY KEY(alerte_id),
   FOREIGN KEY(user_id_creation) REFERENCES utilisateurs(user_id),
   FOREIGN KEY(user_id_resolution) REFERENCES utilisateurs(user_id),
   FOREIGN KEY(bassin_id) REFERENCES bassins(bassin_id),
   FOREIGN KEY(lots_id) REFERENCES lots_poissons(lots_id),
   INDEX idx_resolue (resolue),
   INDEX idx_date_creation (date_creation)
);

-- Insert sample data
INSERT INTO utilisateurs (nom, email, mot_de_passe, role) VALUES
('Admin User', 'admin@fishfarm.com', 'admin123', 'admin'),
('Jean Dupont', 'jean@fishfarm.com', 'tech123', 'technicien'),
('Marie Martin', 'marie@fishfarm.com', 'obs123', 'observateur');

INSERT INTO especes_poissons (nom_scientifique, nom_commun, temperature_optimale_min, temperature_optimale_max, ph_optimal_min, ph_optimal_max) VALUES
('Oncorhynchus mykiss', 'Truite arc-en-ciel', 10.0, 18.0, 6.5, 8.0),
('Salmo trutta', 'Truite fario', 8.0, 16.0, 6.0, 8.5),
('Cyprinus carpio', 'Carpe commune', 15.0, 25.0, 6.5, 8.5);

INSERT INTO types_bassin (nom, description) VALUES
('Bassin d\'élevage', 'Bassin principal pour l\'élevage des poissons'),
('Bassin de quarantaine', 'Bassin pour isoler les nouveaux arrivants'),
('Bassin de reproduction', 'Bassin spécialisé pour la reproduction');

INSERT INTO types_aliment (nom, description, composition, taille_granulometrie, pourcentage_proteines) VALUES
('Granulés croissance', 'Aliment pour la croissance des jeunes poissons', 'Farine de poisson, céréales', '2-4mm', 45.0),
('Granulés maintenance', 'Aliment de maintenance pour poissons adultes', 'Farine de poisson, végétaux', '4-6mm', 35.0);

INSERT INTO bassins (nom, statut, capacite_m3, type_bassin_id, localisation, description) VALUES
('Bassin A1', 'actif', 50.0, 1, 'Zone Nord', 'Bassin principal pour truites'),
('Bassin B2', 'actif', 30.0, 1, 'Zone Sud', 'Bassin secondaire'),
('Bassin Q1', 'vide', 20.0, 2, 'Zone Quarantaine', 'Bassin de quarantaine');

INSERT INTO lots_poissons (espece_id, date_introduction, nombre_initial, poids_moyen_initial_g, provenance, statut) VALUES
(1, NOW(), 500, 25.5, 'Pisciculture Dupont', 'actif'),
(2, DATE_SUB(NOW(), INTERVAL 30 DAY), 300, 45.0, 'Élevage Martin', 'actif');