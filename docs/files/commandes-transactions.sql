#
# Commandes pour effectuer sous l'utilitaire de commandes MySQL
# des exécutions concurrentes de transactions, dans différents
# niveaux d'isolation
#
# Philippe Rigaux, Département d'informatique, CNAM
# Fait partie du support de cours "Bases de données", http://sys.bdpedia.fr
#

# Attention à bien retirer le commit automatique dès la connexion
set autocommit = 0;

#
# Scripts de création des tables
#
create table Client (id_client integer not null,
                 nom varchar(30) not null,
                       nb_places_reservees integer not null,
                       solde integer not null,
                        primary key (id_client))
                            ;

create table Spectacle (id_spectacle integer not null,
                        titre varchar(30) not null,
                          nb_places_offertes integer not null,
                          nb_places_libres integer not null,
                          tarif decimal(10,2) not null,
                         primary key (id_spectacle))
                           ;

#
# Etat initial de la base: 2 clients, un spectacle, 50 places libres
#

set autocommit = 0;
delete from Client;
delete from Spectacle;
insert intoClient values (1, 'Philippe', 0, 2000);
insert intoClient values (2, 'Julie', 0, 350);
insert intoSpectacle values (1, 'Ben hur', 250, 50, 50);
insert intoSpectacle values (2, 'Tartuffe', 120, 30, 30);
commit;

#################################################
#
# Requêtes permettant d'examiner le comportement 
# des transactions (isolation, blocage sur écritures 
# concurrentes, commit et rollback)
#
#################################################

#
# Les sélections
#
select * from Client ;
select * from Spectacle;

# Le client 1 veut réserver 5 places
update Client set nb_places_reservees = nb_places_reservees + 5 where id_client=1;
update Spectacle set nb_places_libres = nb_places_libres - 5;

# Le client 2 veut réserver 2 places
update Client set nb_places_reservees = nb_places_reservees + 2 where id_client=2;
update Spectacle set nb_places_libres = 50 - 2;

#################################################
#
# Requêtes permettant d'effectuer pas à pas, dans deux
# sessions, une exécution concurrente de deux réservations
#
#################################################

select * from Client where id_client=1;
select * from Spectacle;
select * from Client where id_client=2;
select * from Spectacle;
update Client set nb_places_reservees = 0 + 2 where id_client=2;
update Spectacle set nb_places_libres = 50 - 2;
update Client set nb_places_reservees = 0 + 5 where id_client=1;
update Spectacle set nb_places_libres = 50 - 5;

# Les requêtes de la procédure de contrôle
select * from Client where id_client=1;
select * from Client where id_client=2;
select * from Spectacle;

select * from Client where id_client=1 FOR update;

# Et voici les commandes pour régler le niveau d'isolation
set session transaction isolation level read uncommitted;
set session transaction isolation level read committed;
set session transaction isolation level repeatable read;
set session transaction isolation level serializable;
