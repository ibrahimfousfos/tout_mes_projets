# Question 1:
create database if not exists Dropshipping;
use Dropshipping;
drop table produit;
create table if not exists produit
(
ID int primary key not null ,
fournisseur_id int,
nom_produit varchar (50),
categorie varchar (50),
prix_unitaire int
);
select * from produit;
# Question 2:
insert into produit (ID,fournisseur_id,nom_produit,categorie,prix_unitaire)
values 
('1','1','Chargeur_Iphones1','Chargeur_Iphone','17'),
('2','3','Ecouteur_Samsung3','Ecouteur_Samsung','15'),
('3','3','Chargeur_Samsung3','Chargeur_Samsung','19'),
('4','1','Ecouteur_Iphones1','Ecouteur_Iphone','18'),
('5','2','Chargeur_Iphones2','Chargeur_Iphone','16'),
('6','3','Ecouteur_Samsung3','Ecouteur_Samsung','14'),
('7','2','Ecouteur_Iphones2','Ecouteur_Iphone','20'),
('8','2','Ecouteur_Samsung2','Ecouteur_Samsung','13'),
('9','2','Chargeur_Samsung2','Chargeur_Samsung','21')
;
# Question 3;
select nom_produit  from produit where prix_unitaire < 18;

# Question 4;
select categorie , max(prix_unitaire)
from produit 
group by categorie;

# Question 5;
use Dropshipping;
drop table if exists commande_produit_ligne;
create table if not exists commande_produit_ligne
(ID int primary key ,commande_id int ,produit_id int,quantite int);
insert into commande_produit_ligne (ID,commande_id,produit_id,quantite)
values 
('1','1','9','30'),
('2','1','7','60'),
('3','2','5','10'),
('4','2','3','50'),
('5','2','5','20'),
('6','3','1','30'),
('7','3','4','70'),
('8','4','2','40'),
('9','4','6','10'),
('10','4','8','60'),
('11','5','9','50'),
('12','5','4','80')
;

select commande_produit_ligne.ID,commande_id,produit_id,quantite,prix_unitaire
from produit
left OUTER join commande_produit_ligne on commande_produit_ligne.produit_id=produit.ID;

# Question 6;

select commande_produit_ligne.ID,commande_id,produit_id,quantite,prix_unitaire,quantite*prix_unitaire as prix_total
from produit
left OUTER join commande_produit_ligne on commande_produit_ligne.produit_id=produit.ID;

# Question 7;
create table if not exists commande_produit 
(ID int primary key,fournisseur_id int,date_achat date,date_livraison date);
insert into commande_produit (ID,fournisseur_id,date_achat,date_livraison)
values
('1','3','2021-11-01','2021-11-06'),
('2','1','2021-11-15','2021-11-23'),
('3','2','2021-12-01','2021-12-09'),
('4','3','2021-12-05','2021-12-11'),
('5','2','2021-12-10','2021-12-27');

select commande_produit.ID,commande_produit.fournisseur_id,date_achat,date_livraison,
quantite*produit.prix_unitaire+quantite*produit.prix_unitaire as total_commande
from produit,commande_produit_ligne,commande_produit 
where commande_id=commande_produit.ID;

# QCM fait sur un fichier PDF où j'ai surligné en vert les bonnes réponses