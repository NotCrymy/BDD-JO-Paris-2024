INSERT INTO Pays (Nom_pays)
VALUES ('États-Unis');

INSERT INTO Sexe (type_sexe) VALUES
('Homme'),
('Femme');

INSERT INTO Type_medaille (type_type_medaille) VALUES
('Or'),
('Argent'),
('Bronze');

INSERT INTO Delegation (nom_delegation, annee_adhesion_delegation, ID_pays) VALUES
('Délégation des Etats-Unis', '1980-07-19', (SELECT ID_pays FROM Pays WHERE Nom_pays = 'États-Unis'));


INSERT INTO Lieu (nom_lieu, adresse_lieu, type_lieu) VALUES
('Arena Bercy', ' Bd Bercy, 75012 Paris', 'Complexe Sportif'),
('Stade de france', '93200 Saint-Denis', 'Stade');

SET @id_deleg_US = (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation des Etats-Unis');

INSERT INTO Sport (nom_sport) VALUES
('Athlétisme'),
('Basketball');

SET @id_sport_athletisme = (SELECT ID_sport FROM Sport WHERE nom_sport = 'Athlétisme');
SET @id_sport_basket = (SELECT ID_sport FROM Sport WHERE nom_sport = 'Basketball');

INSERT INTO Discipline (nom_discipline, reglement_principal_discipline, ID_sport) VALUES

('100 m - hommes', 'Course de vitesse sur 100 mètres pour hommes', @id_sport_athletisme),
('200 m - hommes', 'Course de vitesse sur 200 mètres pour hommes', @id_sport_athletisme),
('100 m - femmes', 'Course de vitesse sur 100 mètres pour femmes', @id_sport_athletisme),
('200 m - femmes', 'Course de vitesse sur 200 mètres pour femmes', @id_sport_athletisme),


('Basketball 5x5 - hommes', 'Match de basketball classique en 5 contre 5 pour hommes', @id_sport_basket),
('Basketball 5x5 - femmes', 'Match de basketball classique en 5 contre 5 pour femmes', @id_sport_basket);

INSERT INTO Epreuve (nom_epreuve, type_epreuve, record_actuel_epreuve, ID_discipline) VALUES
('Finale 100m Hommes', 'Individuel', 9.58, (SELECT ID_discipline FROM Discipline WHERE nom_discipline = '100 m - hommes')),
('Finale 200m Hommes', 'Individuel', 19.30, (SELECT ID_discipline FROM Discipline WHERE nom_discipline = '200 m - hommes')),
('Finale Basketball 5x5 - hommes', 'Equipe', NULL, (SELECT ID_discipline FROM Discipline WHERE nom_discipline = 'Basketball 5x5 - hommes'));

INSERT INTO Equipe (nom_equipe, entraineur_principal_equipe, ID_delegation) VALUES
('Equipe USA basketball', 'KERR Steve', @id_deleg_US);

SET @id_equipe_basket_us = (SELECT ID_Equipe from Equipe WHERE nom_equipe = 'Equipe USA basketball');


INSERT INTO Sportif (nom_sportif, prenom_sportif, date_naissance_sportif, taille_sportif, poids_sportif, ID_delegation, ID_sexe, ID_Equipe) VALUES

('Curry', 'Stephen', '1988-03-14', 191, 86, @id_deleg_US, 1, @id_equipe_basket_us),
('Edwards', 'Anthony', '2001-08-05', 193, 95, @id_deleg_US, 1, @id_equipe_basket_us),
('James', 'LeBron', '1984-12-30', 203, 113, @id_deleg_US, 1, @id_equipe_basket_us),
('Durant', 'Kevin', '1988-09-29', 205, 108, @id_deleg_US, 1, @id_equipe_basket_us),
('White', 'Derrick', '1994-07-02', 196, 92, @id_deleg_US, 1, @id_equipe_basket_us),
('Haliburton', 'Tyrese', '2000-02-29', 196, 85, @id_deleg_US, 1, @id_equipe_basket_us),
('Tatum', 'Jayson', '1998-03-03', 203, 95, @id_deleg_US, 1, @id_equipe_basket_us),
('Embiid', 'Joel', '1994-03-16', 213, 127, @id_deleg_US, 1, @id_equipe_basket_us),
('Holiday', 'Jrue', '1990-06-12', 193, 98, @id_deleg_US, 1, @id_equipe_basket_us),
('Adebayo', 'Bam', '1997-07-18', 206, 116, @id_deleg_US, 1, @id_equipe_basket_us),
('Davis', 'Anthony', '1993-03-11', 208, 115, @id_deleg_US, 1, @id_equipe_basket_us),
('Booker', 'Devin', '1996-10-30', 198, 94, @id_deleg_US, 1, @id_equipe_basket_us),

('Lyles', 'Noah', '1997-07-18', 177, 77, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation des Etats-Unis'), 1, NULL);

SET @id_reference_medaille := 1; 


INSERT INTO Medaille (ID_reference_medaille, ID_type_medaille, ID_sportif, ID_Equipe, ID_epreuve) VALUES 
(@id_reference_medaille, 1, NULL, @id_equipe_basket_us, 3);

INSERT INTO Medaille (ID_reference_medaille, ID_type_medaille, ID_sportif, ID_epreuve) VALUES 
(@id_reference_medaille, 1, 1, 3),
(@id_reference_medaille, 1, 2, 3),
(@id_reference_medaille, 1, 3, 3),
(@id_reference_medaille, 1, 4, 3),
(@id_reference_medaille, 1, 5, 3),
(@id_reference_medaille, 1, 6, 3),
(@id_reference_medaille, 1, 7, 3),
(@id_reference_medaille, 1, 8, 3),
(@id_reference_medaille, 1, 9, 3),
(@id_reference_medaille, 1, 10, 3),
(@id_reference_medaille, 1, 11, 3),
(@id_reference_medaille, 1, 12, 3);



INSERT INTO Medaille (ID_reference_medaille, ID_sportif, ID_type_medaille, ID_Equipe, ID_epreuve)
VALUES (2, (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Lyles' AND prenom_sportif = 'Noah'), 1, NULL, 1);


INSERT INTO Medaille (ID_reference_medaille, ID_sportif, ID_type_medaille, ID_Equipe, ID_epreuve)
VALUES (3, (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Lyles' AND prenom_sportif = 'Noah'), 3, NULL, 2);


INSERT INTO Se_Deroule (ID_epreuve, ID_lieu)
VALUES
((SELECT ID_epreuve FROM Epreuve WHERE nom_epreuve = 'Finale 100m Hommes'), (SELECT ID_lieu FROM Lieu WHERE nom_lieu = 'Arena Bercy')),
((SELECT ID_epreuve FROM Epreuve WHERE nom_epreuve = 'Finale 200m Hommes'), (SELECT ID_lieu FROM Lieu WHERE nom_lieu = 'Arena Bercy')),
((SELECT ID_epreuve FROM Epreuve WHERE nom_epreuve = 'Basketball 5x5 - hommes'), (SELECT ID_lieu FROM Lieu WHERE nom_lieu = 'Stade de France'));


INSERT INTO Participe_equipe (ID_epreuve, ID_Equipe, date_participation)
VALUES
((SELECT ID_epreuve FROM Epreuve WHERE nom_epreuve = 'Finale Basketball 5x5 - hommes'), @id_equipe_basket_us, '2024-08-01');


INSERT INTO Participe_individuel (ID_sportif, ID_epreuve, date_participation)
VALUES
((SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Lyles' AND prenom_sportif = 'Noah'), (SELECT ID_epreuve FROM Epreuve WHERE nom_epreuve = 'Finale 100m Hommes'), '2024-08-01'),
((SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Lyles' AND prenom_sportif = 'Noah'), (SELECT ID_epreuve FROM Epreuve WHERE nom_epreuve = 'Finale 200m Hommes'), '2024-08-02');


INSERT INTO Pays (Nom_pays) VALUES 
('France'), 
('Canada'), 
('Brésil'), 
('Allemagne'), 
('Japon'), 
('Chine'), 
('Australie'), 
('Royaume-Uni');


INSERT INTO Lieu (nom_lieu, adresse_lieu, type_lieu) VALUES 
('Parc des Princes', '24 Rue du Commandant Guilbaud, 75016 Paris', 'Stade'),
('Accor Arena', '8 Boulevard de Bercy, 75012 Paris', 'Complexe Sportif'),
('Piscine Olympique', '10 Rue de l Eau, 75011 Paris', 'Piscine'),
('Halle Georges Carpentier', '81 Bd Masséna, 75013 Paris', 'Salle Polyvalente');


INSERT INTO Delegation (nom_delegation, annee_adhesion_delegation, ID_pays) VALUES
('Délégation de France', '1924-07-05', (SELECT ID_pays FROM Pays WHERE Nom_pays = 'France')),
('Délégation du Canada', '1976-07-17', (SELECT ID_pays FROM Pays WHERE Nom_pays = 'Canada')),
('Délégation du Brésil', '2016-08-05', (SELECT ID_pays FROM Pays WHERE Nom_pays = 'Brésil')),
('Délégation de l Allemagne', '1972-08-26', (SELECT ID_pays FROM Pays WHERE Nom_pays = 'Allemagne')),
('Délégation du Japon', '1964-10-10', (SELECT ID_pays FROM Pays WHERE Nom_pays = 'Japon'));


INSERT INTO Sport (nom_sport) VALUES 
('Natation'), 
('Gymnastique'), 
('Cyclisme'), 
('Escrime'), 
('Judo'), 
('Football'), 
('Tennis');


SET @id_sport_natation = (SELECT ID_sport FROM Sport WHERE nom_sport = 'Natation');
SET @id_sport_athletisme = (SELECT ID_sport FROM Sport WHERE nom_sport = 'Athlétisme');


INSERT INTO Discipline (nom_discipline, reglement_principal_discipline, ID_sport) VALUES
('100m Nage Libre', 'Course en piscine sur 100 mètres', @id_sport_natation),
('Saut en Longueur', 'Discipline athlétique pour mesurer la distance de saut', @id_sport_athletisme);


SET @id_discipline_natation = (SELECT ID_discipline FROM Discipline WHERE nom_discipline = '100m Nage Libre');
SET @id_discipline_athletisme = (SELECT ID_discipline FROM Discipline WHERE nom_discipline = 'Saut en Longueur');


INSERT INTO Epreuve (nom_epreuve, type_epreuve, record_actuel_epreuve, ID_discipline) VALUES
('Finale 100m Nage Libre', 'Individuel', 47.58, @id_discipline_natation),
('Qualification Saut en Longueur', 'Individuel', 8.35, @id_discipline_athletisme);


SET @id_epreuve_natation = (SELECT ID_epreuve FROM Epreuve WHERE nom_epreuve = 'Finale 100m Nage Libre');
SET @id_epreuve_athletisme = (SELECT ID_epreuve FROM Epreuve WHERE nom_epreuve = 'Qualification Saut en Longueur');


INSERT INTO Se_Deroule (ID_epreuve, ID_lieu) VALUES 
(@id_epreuve_natation, (SELECT ID_lieu FROM Lieu WHERE nom_lieu = 'Piscine Olympique')),
(@id_epreuve_athletisme, (SELECT ID_lieu FROM Lieu WHERE nom_lieu = 'Stade de France'));


INSERT INTO Sportif (date_naissance_sportif, nom_sportif, prenom_sportif, poids_sportif, taille_sportif, ID_delegation, ID_sexe, ID_Equipe) VALUES
('1995-03-10', 'Dupont', 'Jean', 78.5, 1.82, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation de France'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Homme'), NULL),
('1995-03-10', 'Marcelle', 'Jean', 79.5, 1.92, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation de France'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Homme'), NULL),
('1992-11-05', 'Smith', 'Anna', 65.0, 1.68, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation des Etats-Unis'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Femme'), NULL),
('2000-07-22', 'Garcia', 'Luis', 70.2, 1.75, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation du Brésil'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Homme'), NULL);


SET @id_sportif_jean = (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Dupont' AND prenom_sportif = 'Jean');
SET @id_sportif_marcelle = (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Marcelle' AND prenom_sportif = 'Jean');
SET @id_sportif_anna = (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Smith' AND prenom_sportif = 'Anna');
SET @id_sportif_luis = (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Garcia' AND prenom_sportif = 'Luis');


INSERT INTO Participe_individuel (ID_sportif, ID_epreuve, date_participation) VALUES
(@id_sportif_jean, @id_epreuve_athletisme, '2024-07-25'),
(@id_sportif_marcelle, @id_epreuve_athletisme, '2024-07-25'),
(@id_sportif_anna, @id_epreuve_natation, '2024-07-24'),
(@id_sportif_luis, @id_epreuve_athletisme, '2024-07-25'); 


SET @id_medaille_or = (SELECT ID_type_medaille FROM Type_medaille WHERE type_type_medaille = 'Or');
SET @id_medaille_argent = (SELECT ID_type_medaille FROM Type_medaille WHERE type_type_medaille = 'Argent');
SET @id_medaille_bronze = (SELECT ID_type_medaille FROM Type_medaille WHERE type_type_medaille = 'Bronze');


INSERT INTO Medaille (ID_reference_medaille, ID_sportif, ID_type_medaille, ID_epreuve)
VALUES (20, @id_sportif_jean, @id_medaille_or, @id_epreuve_athletisme);

INSERT INTO Medaille (ID_reference_medaille, ID_sportif, ID_type_medaille, ID_epreuve)
VALUES (21, @id_sportif_anna, @id_medaille_argent, @id_epreuve_natation);

INSERT INTO Medaille (ID_reference_medaille, ID_sportif, ID_type_medaille, ID_epreuve)
VALUES (22, @id_sportif_luis, @id_medaille_bronze, @id_epreuve_athletisme);

INSERT INTO Medaille (ID_reference_medaille, ID_sportif, ID_type_medaille, ID_epreuve)
VALUES (23, @id_sportif_marcelle, @id_medaille_argent, @id_epreuve_athletisme);

INSERT INTO Sportif (date_naissance_sportif, nom_sportif, prenom_sportif, poids_sportif, taille_sportif, ID_delegation, ID_sexe, ID_Equipe) VALUES
('1998-04-12', 'Leroy', 'Nicolas', 81.0, 1.88, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation de France'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Homme'), NULL),
('2002-02-18', 'Tanaka', 'Hiro', 69.5, 1.73, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation du Japon'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Homme'), NULL);

INSERT INTO Sportif (date_naissance_sportif, nom_sportif, prenom_sportif, poids_sportif, taille_sportif, ID_delegation, ID_sexe, ID_Equipe) VALUES
('1999-09-07', 'Santos', 'Maria', 62.3, 1.70, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation du Brésil'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Femme'), NULL),
('1997-05-03', 'Brown', 'Liam', 75.4, 1.80, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation du Canada'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Homme'), NULL);


INSERT INTO Participe_individuel (ID_sportif, ID_epreuve, date_participation) VALUES
((SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Leroy' AND prenom_sportif = 'Nicolas' LIMIT 1), @id_epreuve_natation, '2024-07-24'),
((SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Tanaka' AND prenom_sportif = 'Hiro' LIMIT 1), @id_epreuve_natation, '2024-07-24');

INSERT INTO Participe_individuel (ID_sportif, ID_epreuve, date_participation) VALUES
((SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Santos' AND prenom_sportif = 'Maria' LIMIT 1), @id_epreuve_athletisme, '2024-07-25'),
((SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Brown' AND prenom_sportif = 'Liam' LIMIT 1), @id_epreuve_athletisme, '2024-07-25');



INSERT INTO Medaille (ID_reference_medaille, ID_sportif, ID_type_medaille, ID_epreuve) 
VALUES (24, (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Leroy' AND prenom_sportif = 'Nicolas' LIMIT 1), @id_medaille_bronze, @id_epreuve_natation);

INSERT INTO Medaille (ID_reference_medaille, ID_sportif, ID_type_medaille, ID_epreuve) 
VALUES (25, (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Santos' AND prenom_sportif = 'Maria' LIMIT 1), @id_medaille_or, @id_epreuve_natation);

INSERT INTO Delegation (nom_delegation, annee_adhesion_delegation, ID_pays) VALUES
('Délégation de Chine', '1984-08-18', (SELECT ID_pays FROM Pays WHERE Nom_pays = 'Chine')),
('Délégation de l Australie', '2000-09-15', (SELECT ID_pays FROM Pays WHERE Nom_pays = 'Australie')),
('Délégation du Royaume-Uni', '1948-07-29', (SELECT ID_pays FROM Pays WHERE Nom_pays = 'Royaume-Uni')), 
('Délégation Étrangère', '2024-01-01', NULL);

INSERT INTO Sportif (date_naissance_sportif, nom_sportif, prenom_sportif, poids_sportif, taille_sportif, ID_delegation, ID_sexe, ID_Equipe) VALUES
('1993-12-12', 'Thompson', 'James', 80.5, 1.85, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation du Royaume-Uni'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Homme'), NULL),
('1995-04-22', 'Wang', 'Li', 60.0, 1.65, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation de Chine'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Femme'), NULL),
('1998-09-17', 'Smith', 'Alex', 75.0, 1.78, (SELECT ID_delegation FROM Delegation WHERE nom_delegation = 'Délégation Étrangère'), (SELECT ID_sexe FROM Sexe WHERE type_sexe = 'Homme'), NULL);

SET @id_sport_athletisme = (SELECT ID_sport FROM Sport WHERE nom_sport = 'Athlétisme' LIMIT 1);

INSERT INTO Discipline (nom_discipline, reglement_principal_discipline, ID_sport) VALUES
('200m Sprint', 'Course sur piste de 200 mètres', @id_sport_athletisme) ON DUPLICATE KEY UPDATE ID_discipline=ID_discipline;
SET @id_discipline_sprint = (SELECT ID_discipline FROM Discipline WHERE nom_discipline = '200m Sprint' LIMIT 1);

INSERT INTO Epreuve (nom_epreuve, type_epreuve, record_actuel_epreuve, ID_discipline) VALUES
('Finale 200m Sprint', 'Individuel', 19.32, @id_discipline_sprint) ON DUPLICATE KEY UPDATE ID_epreuve=ID_epreuve;
SET @id_epreuve_sprint = (SELECT ID_epreuve FROM Epreuve WHERE nom_epreuve = 'Finale 200m Sprint' LIMIT 1);

INSERT INTO Lieu (nom_lieu, adresse_lieu, type_lieu) VALUES
('Stade Olympique', '1 Boulevard des Athlètes, 75015 Paris', 'Stade') ON DUPLICATE KEY UPDATE ID_lieu=ID_lieu;
SET @id_lieu_stade = (SELECT ID_lieu FROM Lieu WHERE nom_lieu = 'Stade Olympique' LIMIT 1);

INSERT INTO Se_Deroule (ID_epreuve, ID_lieu) 
SELECT * FROM (SELECT @id_epreuve_sprint AS ID_epreuve, @id_lieu_stade AS ID_lieu) AS tmp
WHERE NOT EXISTS (
    SELECT 1 FROM Se_Deroule WHERE ID_epreuve = @id_epreuve_sprint AND ID_lieu = @id_lieu_stade
) LIMIT 1;

INSERT INTO Participe_individuel (ID_sportif, ID_epreuve, date_participation) VALUES
((SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Thompson' AND prenom_sportif = 'James' LIMIT 1), @id_epreuve_sprint, '2024-08-01'),
((SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Wang' AND prenom_sportif = 'Li' LIMIT 1), @id_epreuve_sprint, '2024-08-01'),
((SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Smith' AND prenom_sportif = 'Alex' LIMIT 1), @id_epreuve_sprint, '2024-08-01');

INSERT INTO Medaille (ID_reference_medaille, ID_sportif, ID_type_medaille, ID_epreuve) VALUES
(30, (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Thompson' AND prenom_sportif = 'James' LIMIT 1), (SELECT ID_type_medaille FROM Type_medaille WHERE type_type_medaille = 'Or'), @id_epreuve_sprint),
(31, (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Wang' AND prenom_sportif = 'Li' LIMIT 1), (SELECT ID_type_medaille FROM Type_medaille WHERE type_type_medaille = 'Argent'), @id_epreuve_sprint),
(32, (SELECT ID_sportif FROM Sportif WHERE nom_sportif = 'Smith' AND prenom_sportif = 'Alex' LIMIT 1), (SELECT ID_type_medaille FROM Type_medaille WHERE type_type_medaille = 'Bronze'), @id_epreuve_sprint);