--cette requête sélectionne le nom d'une délégation et le nombre total de médailles qu'elle a remportées. la requête utilise des sous-requêtes
--pour chaque délégation, on compte le nombre distinct de médailles gagnées par les sportifs qui lui sont associés.
SELECT 
    nom_delegation,
    (SELECT 
        COUNT(DISTINCT ID_reference_medaille)  
    FROM 
        Medaille 
    WHERE 
        ID_sportif IN (  
            SELECT ID_sportif 
            FROM Sportif 
            WHERE ID_delegation = d.ID_delegation
        )
    ) AS nombre_medaille
FROM 
    Delegation d;

--on peut aussi avoir un meilleur détail comme ça :
SELECT 
    Dlg.nom_delegation, 
    COUNT(DISTINCT CASE WHEN TM.type_type_medaille = 'Or' THEN M.ID_reference_medaille END) AS medailles_or,
    COUNT(DISTINCT CASE WHEN TM.type_type_medaille = 'Argent' THEN M.ID_reference_medaille END) AS medailles_argent,
    COUNT(DISTINCT CASE WHEN TM.type_type_medaille = 'Bronze' THEN M.ID_reference_medaille END) AS medailles_bronze
FROM 
    Medaille M
JOIN 
    Type_medaille TM ON M.ID_type_medaille = TM.ID_type_medaille
JOIN 
    Sportif S ON M.ID_sportif = S.ID_sportif
JOIN 
    Delegation Dlg ON S.ID_delegation = Dlg.ID_delegation
GROUP BY 
    Dlg.nom_delegation;

--cette requête retourne les titres des sports et des disciplines pratiqués par des sportifs
--ayant remporté une médaille (or, argent ou bronze) dans des épreuves individuelles uniquement.
SELECT DISTINCT 
    S.nom_sport,           
    D.nom_discipline       
FROM 
    Sport S
JOIN 
    Discipline D ON S.ID_sport = D.ID_sport  
JOIN 
    Epreuve E ON D.ID_discipline = E.ID_discipline  
JOIN 
    Participe_individuel PI ON E.ID_epreuve = PI.ID_epreuve  
JOIN 
    Medaille M ON PI.ID_sportif = M.ID_sportif  
WHERE 
    M.ID_type_medaille IN (1, 2, 3); 

--cette requête retourne le pourcentage de médailles d'argent par rapport au nombre total de médailles.
SELECT 
    (COUNT(CASE WHEN M.ID_type_medaille = 2 THEN 1 END) * 100.0) / COUNT(*) AS pourcentage_argent
FROM 
    Medaille M;

--cette requête retourne les noms des sportifs ayant remporté une médaille dans toutes les disciplines d'un sport spécifique (par exemple, natation),
--ainsi que le nom de leur entraîneur (coach) et de leur délégation. (division relationelle ici)
SELECT 
    S.nom_sportif, 
    S.prenom_sportif, 
    Eqp.entraineur_principal_equipe AS nom_coach,
    Dlg.nom_delegation AS delegation
FROM 
    Sportif S
JOIN 
    Participe_individuel PI ON S.ID_sportif = PI.ID_sportif
JOIN 
    Epreuve E ON PI.ID_epreuve = E.ID_epreuve
JOIN 
    Discipline D ON E.ID_discipline = D.ID_discipline
JOIN 
    Sport Sp ON D.ID_sport = Sp.ID_sport
LEFT JOIN 
    Equipe Eqp ON S.ID_Equipe = Eqp.ID_Equipe
LEFT JOIN 
    Delegation Dlg ON S.ID_delegation = Dlg.ID_delegation
WHERE 
    Sp.nom_sport = 'Natation'
GROUP BY 
    S.ID_sportif, S.nom_sportif, S.prenom_sportif, Eqp.entraineur_principal_equipe, Dlg.nom_delegation
HAVING 
    COUNT(DISTINCT D.ID_discipline) = (
        SELECT COUNT(DISTINCT D2.ID_discipline)
        FROM Discipline D2
        JOIN Sport Sp2 ON D2.ID_sport = Sp2.ID_sport
        WHERE Sp2.nom_sport = 'Natation'
    );

--l'age moyen des médaillés
SELECT 
    AVG(YEAR(CURDATE()) - YEAR(S.date_naissance_sportif)) AS age_moyen_medailles
FROM 
    Sportif S
JOIN 
    Medaille M ON S.ID_sportif = M.ID_sportif;

--l'age moyen des médaillés selon la discipline
--(le left join permet de joindre même quand la condition est null : si une ligne de la table de gauche (par exemple, sportif)
--n’a pas de correspondance dans la table de droite (par exemple, participe_individuel), le left join retournera quand même cette ligne de sportif avec des valeurs null pour les colonnes de participe_individuel.
--cela permet de garder toutes les lignes de la table de gauche, indépendamment de la présence ou de l’absence de correspondances dans la table de droite)
SELECT 
    D.nom_discipline,
    AVG(YEAR(CURDATE()) - YEAR(S.date_naissance_sportif)) AS age_moyen_medailles
FROM 
    Sportif S
JOIN 
    Medaille M ON S.ID_sportif = M.ID_sportif
LEFT JOIN 
    Participe_individuel PI ON S.ID_sportif = PI.ID_sportif
LEFT JOIN 
    Participe_equipe PE ON S.ID_Equipe = PE.ID_Equipe
JOIN 
    Epreuve E ON (PI.ID_epreuve = E.ID_epreuve OR PE.ID_epreuve = E.ID_epreuve)
JOIN 
    Discipline D ON E.ID_discipline = D.ID_discipline
GROUP BY 
    D.nom_discipline;

--q4 : liste des athlètes (nom et prénom) ayant participé à une épreuve spécifique (par exemple, finale 100m hommes) et ayant gagné une médaille d'or
--cette requête sélectionne les athlètes ayant participé à une épreuve spécifique (finale 100m hommes) et ayant remporté une médaille d'or.
SELECT 
    S.nom_sportif, S.prenom_sportif
FROM 
    Sportif S
JOIN 
    Participe_individuel PI ON S.ID_sportif = PI.ID_sportif
JOIN 
    Epreuve E ON PI.ID_epreuve = E.ID_epreuve
JOIN 
    Medaille M ON S.ID_sportif = M.ID_sportif
WHERE 
    E.nom_epreuve = 'Finale 100m Hommes' AND M.ID_type_medaille = 1;  

--q5 : nombre de médailles d'or remportées par chaque pays (en fonction de la délégation)
--cette requête calcule le nombre de médailles d'or remportées par chaque pays, en se basant sur les délégations.
SELECT 
    P.Nom_pays, COUNT(DISTINCT M.ID_reference_medaille) AS nb_medaille_or
FROM 
    Pays P
JOIN 
    Delegation D ON P.ID_pays = D.ID_pays
JOIN 
    Sportif S ON D.ID_delegation = S.ID_delegation
JOIN 
    Medaille M ON S.ID_sportif = M.ID_sportif
WHERE 
    M.ID_type_medaille = 1  
GROUP BY 
    P.Nom_pays;

--q6 : le nom et prenom des athlètes ayant participé à au moins deux épreuves différentes
--cette requête sélectionne les athlètes qui ont participé à au moins deux épreuves différentes.
SELECT 
    S.nom_sportif, S.prenom_sportif
FROM 
    Sportif S
JOIN 
    Participe_individuel PI ON S.ID_sportif = PI.ID_sportif
GROUP BY 
    S.ID_sportif
HAVING 
    COUNT(DISTINCT PI.ID_epreuve) >= 2;

--cette requête sélectionne les informations des sportifs ayant remporté une médaille,
--en affichant leur nom, prénom, date de naissance, la délégation à laquelle ils appartiennent, ainsi que le type de médaille remportée (or, argent, bronze).
--la requête inclut aussi bien les médailles individuelles que celles remportées par équipe.
--les résultats sont triés du plus agé au plus jeune
SELECT DISTINCT 
    S.nom_sportif, 
    S.prenom_sportif, 
    S.date_naissance_sportif,
    D.nom_delegation AS delegation,
    TM.type_type_medaille AS type_medaille
FROM 
    Sportif S
JOIN 
    Medaille M ON S.ID_sportif = M.ID_sportif
JOIN 
    Delegation D ON S.ID_delegation = D.ID_delegation
JOIN 
    Type_medaille TM ON M.ID_type_medaille = TM.ID_type_medaille
WHERE 
    M.ID_Equipe IS NULL 
    OR M.ID_Equipe IN (SELECT ID_Equipe FROM Equipe)
ORDER BY 
    S.date_naissance_sportif ASC;

--cette requête sélectionne les informations des athlètes ayant remporté une médaille d'or
--dans des épreuves individuelles. elle inclut le nom et prénom du sportif, la date de naissance,
--le nom et type d'épreuve, la date de participation, le lieu de l'épreuve (nom et adresse),
--ainsi que la discipline et le sport associés.
SELECT 
    Sportif.nom_sportif,
    Sportif.prenom_sportif,
    Sportif.date_naissance_sportif,
    Epreuve.nom_epreuve,
    Epreuve.type_epreuve,
    Epreuve.record_actuel_epreuve,
    Participe_individuel.date_participation,
    Lieu.nom_lieu,
    Lieu.adresse_lieu,
    Type_medaille.type_type_medaille,
    Discipline.nom_discipline,
    Sport.nom_sport
FROM 
    Sportif
JOIN 
    Medaille ON Sportif.ID_sportif = Medaille.ID_sportif
JOIN 
    Type_medaille ON Medaille.ID_type_medaille = Type_medaille.ID_type_medaille
JOIN 
    Participe_individuel ON Sportif.ID_sportif = Participe_individuel.ID_sportif 
                          AND Participe_individuel.ID_epreuve = Medaille.ID_reference_medaille
JOIN 
    Epreuve ON Epreuve.ID_epreuve = Participe_individuel.ID_epreuve
JOIN 
    Discipline ON Discipline.ID_discipline = Epreuve.ID_discipline
JOIN 
    Sport ON Sport.ID_sport = Discipline.ID_sport
JOIN 
    Se_Deroule ON Se_Deroule.ID_epreuve = Epreuve.ID_epreuve
JOIN 
    Lieu ON Lieu.ID_lieu = Se_Deroule.ID_lieu
WHERE 
    Type_medaille.type_type_medaille = 'Or'
    AND Epreuve.type_epreuve = 'Individuel';