#question 1 

CREATE DATABASE if not exists COVID;
USE COVID;
set sql_safe_updates = 0;# cela va nous permettre de faire des altertable plus tard 
#question 2

CREATE TABLE if not exists VACCINAL (
    CléVAC int(4) PRIMARY KEY auto_increment,
    Nom varchar(17),
    Prénom varchar(20),
    Dose varchar(50),
    nombredose double,
    nombretest int
);
CREATE TABLE if not exists NAME (
    Clépos int(3) PRIMARY KEY,
    ID_pos int(4),
    Code_postal double,
    commune varchar(20),#dans l'enoncé la colonne commune est une décimal et code postale une chaine de caractere .j'ai decide de les inverser pour pouvoir insere les valeurs (les noms des communes )
    subvention double,
    catégoriesocio varchar(50)
);

#question 3

INSERT INTO VACCINAL (Nom, Prénom, Dose, nombredose, nombretest)
VALUES
    ('Feriani', 'Younas', 'pfizer', 3, 5),
    ('Sawsana', 'Zimouche', 'moderna', 2, 10),
    ('Berrannoum', 'Rita', 'ARN', 0, 1),
    ('UNG', 'Laura', 'pfizer', 4, 0),
    ('Thibault', 'Alliot', 'moderna', 0, 6),
    ('Nastar', 'Felix', 'ARN', 0, 7),
    ('Cheron', 'Thomas', 'moderna', 1, 9),
    ('Abdelli', 'Nour', 'pfizer', 1, 3),
    ('Sellan', 'Edna', 'ARN', 2, 6),
    ('Helou', 'Jeremy', 'moderna', 0, 8);

INSERT INTO NAME (Clépos, ID_pos, Code_postal, commune, subvention, catégoriesocio)
VALUES
    (1, 1, 95100, 'ARGENTEUIL', 100, 'cadre'),
    (2, 2, 92400, 'COURBEVOIE', 80, 'non cadre'),
    (3, 3, 92000, 'NANTERRE', 0, 'retraite'),
    (4, 4, 75010, 'PARIS', 150, 'cadre'),
    (5, 5, 75013, 'PARIS', 0, 'non cadre'),
    (6, 6, 95100, 'ARGENTEUIL', 50, 'retraite'),
    (7, 7, 92400, 'COURBEVOIE', 50, 'cadre'),
    (8, 8, 92000, 'NANTERRE', 50, 'non cadre'),
    (9, 9, 75010, 'PARIS', 100, 'retraite'),
    (10, 10, 75013, 'PARIS', 0, 'cadre');

# question 4

DELETE FROM NAME WHERE Clépos =10;

#question 5

UPDATE NAME SET subvention = subvention + 1;

#question 6

alter table VACCINAL change column nombretest nombretest2 int ;
UPDATE VACCINAL SET nombretest2 = nombretest2 - 2;

#question 7

SELECT AVG(nombredose) AS MoyenneDoses FROM VACCINAL;
SELECT Dose, AVG(nombredose) AS MoyenneDoses
FROM VACCINAL
GROUP BY Dose;

#question 8

select*, 
case when nombredose>=2 then 'oui' 
else 'non'end 
as pass from VACCINAL;

#question 9

select*,
   (SUM(CASE WHEN nombredose >= 2 THEN 1 ELSE 0 END) / max(CléVAC)) * 100 AS pourcentage_pass
FROM VACCINAL;

#question 10

alter table NAME add column age int ;
update name set age=ROUND(RAND() * 90);

#question 11

ALTER TABLE VACCINAL
add column sexe varchar(10);
UPDATE VACCINAL SET sexe = CASE WHEN RAND() > 0.5 THEN 'Homme' ELSE 'Femme' END;

#question 12

alter table vaccinal change column CléVAC identifiant int;

#question 13

SELECT *,
    CASE
        WHEN age>=0 AND age<=30 THEN '[0-30]'
        WHEN age>=31 AND age<=60 THEN '[30-60]'
        WHEN age>= 61 AND age<=90 THEN '[60-90]'
        ELSE 'Autre'
    END AS classe
FROM NAME;

#question 14

SELECT MAX(nombredose) AS MaxDose, MIN(nombredose) AS MinDose
FROM VACCINAL;

#question 15

alter table vaccinal add column name1 varchar(20);
update vaccinal set name1=upper(Nom);
select*from vaccinal;

#question 16

alter table vaccinal add column surname varchar(20);
update vaccinal set surname=lower(Prénom);

#question 17

alter table vaccinal add column come varchar (20);
update vaccinal set come=concat(name1,' ',surname);#j'ai rajouter ' ' car sinon lorsqu'on fait "select*from vaccinal" on voit que le nom et prénom sont concatene comme demandé mais illisible 

#question 18
alter table VACCINAL add prod varchar(5);
update vaccinal set prod=substr(prénom, -5,5);#-5 c'est la cinquieme lettre à partir de la fin

#question 19

update name set subvention = subvention + 100
where Clépos <= 5;

#question 20

create table if not exists vaccination as 
select*
from vaccinal
inner join name on identifiant=Clépos;

#question 21

SELECT Clépos, COUNT(*)
FROM VACCINATION
GROUP BY Clépos
HAVING COUNT(*) >= 2; #si il y a une ligne qui apparait alors le count sera egale ou spérieur à 2 et donc il y a une présence de doublon



