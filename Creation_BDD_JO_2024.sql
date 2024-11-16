CREATE TABLE Lieu(
   ID_lieu INT AUTO_INCREMENT,
   nom_lieu VARCHAR(50),
   adresse_lieu VARCHAR(50),
   type_lieu VARCHAR(50),
   PRIMARY KEY(ID_lieu)
);

CREATE TABLE Pays(
   ID_pays INT AUTO_INCREMENT,
   Nom_pays VARCHAR(50),
   PRIMARY KEY(ID_pays)
);

CREATE TABLE Sexe(
   ID_sexe INT AUTO_INCREMENT,
   type_sexe VARCHAR(10),
   PRIMARY KEY(ID_sexe)
);

CREATE TABLE Sport(
   ID_sport INT AUTO_INCREMENT,
   nom_sport VARCHAR(50),
   PRIMARY KEY(ID_sport)
);

CREATE TABLE Type_medaille(
   ID_type_medaille INT AUTO_INCREMENT,
   type_type_medaille VARCHAR(50),
   PRIMARY KEY(ID_type_medaille)
);

CREATE TABLE Delegation(
   ID_delegation INT AUTO_INCREMENT,
   nom_delegation VARCHAR(50),
   annee_adhesion_delegation DATE,
   ID_pays INT NOT NULL,
   PRIMARY KEY(ID_delegation),
   UNIQUE(ID_pays),
   FOREIGN KEY(ID_pays) REFERENCES Pays(ID_pays)
);

CREATE TABLE Discipline(
   ID_discipline INT AUTO_INCREMENT,
   nom_discipline VARCHAR(50),
   reglement_principal_discipline TEXT,
   ID_sport INT NOT NULL,
   PRIMARY KEY(ID_discipline),
   FOREIGN KEY(ID_sport) REFERENCES Sport(ID_sport)
);

CREATE TABLE Epreuve(
   ID_epreuve INT AUTO_INCREMENT,
   nom_epreuve VARCHAR(50),
   type_epreuve VARCHAR(50),
   record_actuel_epreuve DECIMAL(8,2),
   ID_discipline INT NOT NULL,
   PRIMARY KEY(ID_epreuve),
   FOREIGN KEY(ID_discipline) REFERENCES Discipline(ID_discipline)
);

CREATE TABLE Equipe(
   ID_Equipe INT AUTO_INCREMENT,
   nom_equipe VARCHAR(50),
   entraineur_principal_equipe VARCHAR(50),
   ID_delegation INT NOT NULL,
   PRIMARY KEY(ID_Equipe),
   FOREIGN KEY(ID_delegation) REFERENCES Delegation(ID_delegation)
);

CREATE TABLE Sportif(
   ID_sportif INT AUTO_INCREMENT,
   date_naissance_sportif DATE,
   nom_sportif VARCHAR(50),
   prenom_sportif VARCHAR(50),
   poids_sportif DECIMAL(5,2),
   taille_sportif DECIMAL(5,2),
   ID_delegation INT NOT NULL,
   ID_sexe INT NOT NULL,
   ID_Equipe INT,
   PRIMARY KEY(ID_sportif),
   FOREIGN KEY(ID_delegation) REFERENCES Delegation(ID_delegation),
   FOREIGN KEY(ID_sexe) REFERENCES Sexe(ID_sexe),
   FOREIGN KEY(ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

CREATE TABLE Medaille(
   ID_medaille INT AUTO_INCREMENT,
   ID_epreuve INT NOT NULL,
   ID_reference_medaille INT,
   ID_sportif INT,
   ID_type_medaille INT NOT NULL,
   ID_Equipe INT,
   PRIMARY KEY(ID_medaille),
   FOREIGN KEY(ID_sportif) REFERENCES Sportif(ID_sportif),
   FOREIGN KEY(ID_type_medaille) REFERENCES Type_medaille(ID_type_medaille),
   FOREIGN KEY(ID_Equipe) REFERENCES Equipe(ID_Equipe),
   FOREIGN KEY(ID_epreuve) REFERENCES Epreuve(ID_epreuve)
);

CREATE TABLE Se_Deroule(
   ID_epreuve INT,
   ID_lieu INT,
   PRIMARY KEY(ID_epreuve, ID_lieu),
   FOREIGN KEY(ID_epreuve) REFERENCES Epreuve(ID_epreuve),
   FOREIGN KEY(ID_lieu) REFERENCES Lieu(ID_lieu)
);

CREATE TABLE Participe_equipe(
   ID_epreuve INT,
   ID_Equipe INT,
   date_participation DATE,
   PRIMARY KEY(ID_epreuve, ID_Equipe),
   FOREIGN KEY(ID_epreuve) REFERENCES Epreuve(ID_epreuve),
   FOREIGN KEY(ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

CREATE TABLE Participe_individuel(
   ID_sportif INT,
   ID_epreuve INT,
   date_participation VARCHAR(50),
   PRIMARY KEY(ID_sportif, ID_epreuve),
   FOREIGN KEY(ID_sportif) REFERENCES Sportif(ID_sportif),
   FOREIGN KEY(ID_epreuve) REFERENCES Epreuve(ID_epreuve)
); 
