.. |nbsp| unicode:: 0xA0  
   :trim:  


.. _chap-tpoptim:

###############################
Travaux pratiques: optimisation
###############################


***********************************
Atelier en ligne: plans d'exécution
***********************************

Ces travaux pratiques consistent à exécuter des requêtes sur de véritables bases de données gérées par le 
système PostgreSQL, et à interpéter le plan d'exécution de ces requêtes.

Vous diposez pour cela d'un outil en ligne qui vous permet d'entrer des requêtes SQL, de les exécuter, et 
de consulter le résultat et, surtout, le plan d'exécution. Les exercices  consistent en deux parties

  - étant donnée une question posée sur la base, plusieurs requêtes SQL sont proposées; vous devez trouvez celle(s) qui 
    exprime(nt) correctement la question - il peut y en avoir plusieurs, équivalentes;
  - vous pouvez alors copier une des requêtes SQL correctes dans la fenêtre d'entrée de l'outil en ligne, et inspecter le plan d'exécution; des questions vous sont posées sur l'interprétation de ce plan.

Le schéma de la base ne comprend que trois tables: Artiste contient des personnalités du cinéma, 
acteurs/actrices ou réalisateur/réalisatrice; Film contient des films, chaque film étant lié à son/sa 
réalisateur/réalisatrice; enfin la table Rôle indique quels acteurs ont tourné dans quels films. 
Ce sont les tables qui ont servi de support aux exemples du cours. 

Voici leur schéma:

.. code-block:: sql

    CREATE TABLE Artiste (
       id integer,
      nom varchar(30),
      prenom varchar(30),
      annee_naissance integer,
      primary key (id)
      )
      
      CREATE TABLE Film (
            id integer,
            titre varchar(50),
            annee integer 
            id_realisateur integer,
            genre varchar(30),
            resume text,
            code_pays varchar(4),
            version integer,
            primary key (id),
            foreign key (id_realisateur) references Artiste(id),
            foreign key (code_pays) references Pays(code)
            )
            
            CREATE TABLE Role (
               id_film integer,
               id_acteur integer,
               nom_role varchar(60),
               primary key (id_film, id_acteur) ,
               foreign key (id_film) references Film(id),
               foreign key (id_acteur) references Artiste(id)
            )
            
            
Sur ce schéma, trois bases ont été créées.

 - La première, nommée Minus, contient quelques centaines de films et artistes
 - La seconde, nommée Magnus, contient quelques millions de films et d'acteurs - elle a été obtenue en 
   dupliquant les données de la base Minus, ne vous étonnez donc pas de trouver beaucoup de fois le même titre ou le même nom: nous cherchons ici un volume suffisant pour étudier comment le plan d'exécution d'une requête est adapté par PostgreSQL par rapport à celui de la base Minus.
 - Enfin, la troisième, nommée Magnindex, a le même contenu que Magnus, mais des index supplémentaires on été créés.

Pour chaque requête, vous êtes invités à étudier le plan d'exécution produit par PostgreSQL sur chaque base. La 
variation de ce plan correspond, comme expliqué en cours, à la prise en compte du contexte (volumétrie et présence d'index) 
par l'optimiseur de PostgreSQL. À vous d'interpréter ces variations et de réponde pertinemment aux questions posées.

Voici un exemple commenté d'interrogation et d'analyse du plan d'exécution. 


Un exemple
----------

La question posée est la suivante :
*Donnez tous les titres des films parus après (au sens large) l'an 2000.*
Parmi les requêtes suivantes, laquelle n'exprime pas cette question?

       
    .. eqt:: defSerial1

       A) :eqt:`I` select titre from Film where annee >= 2000
       #) :eqt:`C` select annee, count(*) from Film group by annee having count(*) >= 2000
       #) :eqt:`I` select titre from Film where not (annee < 2000)
       #) :eqt:`I` select titre from Film where annee - 2000 >= 0


Souvenez-vous: il peut y avoir plusieurs requêtes SQL équivalentes mais différentes syntaxiquement. 
À vous de jouer: si vous ne trouvez pas la bonne réponse, il est clairement nécessaire de vous lancer dans 
une sérieuse révision SQL avant d'aller plus loin.

Maintenant, vous pouvez copier/coller une des bonnes requêtes dans le formulaire ci-dessous, et l'exécuter. Vous obtiendrez 
un échantillon du résultat  et, 
surtout, le plan d'exécution du SGBD (PostgreSQL).

L'interprétation du plan
------------------------

En appliquant la requête à la base Minus, vous devriez obtenir un plan d'exécution de la forme

.. code-block:: text
  
     Parcours séquentiel de film (temps de réponse:0.00 ; temps d'exécution:7.10 ; 
                 nombre de nuplets:20 ; mémoire allouée:15)
       filter: (annee >= 2000) 
  

Que nous dit PostgreSQL? Que la table ``Film`` est parcourue séquentiellement, en appliquant un 
filtre sur l'année. De plus, pour chaque opérateur du plan d'exécution, PostgreSQL a l'amabilité de 
nous fournir une estimation du coût d'exécution:

 -  le temps de réponse est le temps mis pour obtenir le premier nuplet;
 - le temps d'exécution est le temps mis pour exécuter l'ensemble de la requête.

L'unité des valeurs affichées pour ces mesures est arbitraire et dépend des capacités du serveur: l'intérêt 
est de les comparer pour comprendre l'ordre de grandeur de l'optimisation obtenue. Grossièrement, il s'agit 
du nombre de blocs auxquels Postgres doit accéder pour satisfaire la requête (faites une recherche "Postgres explain" pour 
en savoir - un peu - plus).

Postgres nous donne également une estimation du nombre de nuplets ramenés par la requête et la taille moyenne de 
chaque nuplet dans le résultat (un titre, donc).


Première requêtes
=================


Vous devriez maintenant pouvoir répondre aux questions suivantes sans aucun problème : 

    .. eqt:: tpoptim2

       Un index est-il utilisé pour ce plan d'exécution? 
       
       A) :eqt:`I` Oui
       #) :eqt:`C` Non
       
    .. eqt:: tpoptim3

       La table Film doit-elle être parcourue séquentiellement? 
       
       A) :eqt:`C` Oui
       #) :eqt:`I` Non
 
    .. eqt:: tpoptim4

       Un index sur l'année peut-il améliorer le temps d'exécution? 
       
       A) :eqt:`I` Oui
       #) :eqt:`I` Non
       #) :eqt:`C` Pas forcément
 
Et en changeant de base
-----------------------


Nous reprenons maintenant la même requête, mais vous allez l'exécuter en changeant la base et la 
sélectivité de la requête : essayez d'abord avec Minus, puis avec Magnus, puis avec Magnindex.

Commençons par chercher les films parus après 2000. Le résultat a peu d'intérêt et vous montre seulement 
de nombreuses réplications d'un même film pour Magnus et Magnindex. Regardez surtout le temps et de 
réponse et de temps d'exécution tels qu'ils sont évalués par Postgres, pour les bases Magnus et 
Magnindex qui ont la même volumétrie mais une organisation physique différente: Magnindex a plus d'index.


    .. eqt:: tpoptim5

       Un index est-il utilisé pour  magnindex
       
       A) :eqt:`C` Oui
       #) :eqt:`I` Non
       
    .. eqt:: tpoptim6

       Pour quelle base a-t-on le meilleur temps de réponse?
       
       A) :eqt:`C` Magnus
       #) :eqt:`I` Magnindex
       #) :eqt:`I` Les temps de réponse sont les mêmes
 
    .. eqt:: tpoptim7

       Pour quelle base a-t-on le meilleur temps d'exécution?
       
       A) :eqt:`I` Magnus
       #) :eqt:`C` Magnindex
       #) :eqt:`I` Les temps d'exécution sont les mêmes

    .. eqt:: tpoptim8

       On veut maintenant tous les films parus après 1980. Un index est-il utilisé pour la base Magnindex?
       
       A) :eqt:`I` Oui
       #) :eqt:`C` Non

Ordonner, grouper, dé-dupliquer
===============================

Déterminez les requêtes qui vont introduire un opérateur 
bloquant dans le plan d'exécution.


    .. eqt:: tpoptim9
       
       A) :eqt:`I` select annee - 2000 from Film
       #) :eqt:`C` select distinct annee from Film
       #) :eqt:`C` select annee, count(*) from Film group by annee
       #) :eqt:`C` select max(annee) from Film where annee >= 2000
       #) :eqt:`C` select titre from Film order by annee
       #) :eqt:`I` sans réponse

Nous allons pouvoir le vérifier avec Postgres.
Copier/coller une des bonnes requêtes dans le formulaire ci-dessous, et exécutez-le. 
Vous obtiendrez le résultat dans un onglet 
et le plan d'exécution du SGBD (PostgreSQL) dans un autre. Puis répondez aux questions 
qui suivent : 

    .. eqt:: tpoptim10
       
       Quelle méthode emploie Postgres pour trouver les doublons et les éliminer?
       
       A) :eqt:`I` Le tri
       #) :eqt:`C` Le hachage
       #) :eqt:`I` Le parcours séquentiel

    .. eqt:: tpoptim11
       
       Quelle valeur nous confirme que l'opérateur est bloquant?
       
       A) :eqt:`I` Le temps d'exécution
       #) :eqt:`C` Le temps de réponse
       #) :eqt:`I` L'utilisation de la mémoire


    .. eqt:: tpoptim12
       
       L'existence d'un index peut-elle éviter de recourir à un 
       opérateur bloquant pour les requêtes ci-dessus?

       
       A) :eqt:`I` Oui
       #) :eqt:`C` Non
       #) :eqt:`I` sans réponse

Requêtes avec ou sans index
============================

Voici un ensemble de requêtes. Indiquez celles pour lesquelles il est possible d'utiliser 
un index. Rappelons que toutes les clés primaires sont indexées par un arbre B, que la 
clé primaire de Film est l'attribut id, et que la clé primaire de Rôle est la paire 
(id_film, id_acteur).


    .. eqt:: tpoptim12
       
       A) :eqt:`I` select * from Film where titre='Alien'
       #) :eqt:`I` select * from Film where id_realisateur=65
       #) :eqt:`C` select * from Film where id=34
       #) :eqt:`C` select * from Role where id_film=34 and id_acteur=65
       #) :eqt:`C` select * from Role where id_film=34

Nous allons pouvoir le vérifier avec Postgres.
Exécutez les requêtes ci-dessus pour consulter le plan d'exécution de Postgres et 
vérifier si ce dernier utilise ou non l'index. Pour chaque requête, regardez si le plan 
est le même pour la base Minus et la base Magnus. Puis répondez aux questions qui suivent : 


    .. eqt:: tpoptim13
       
       Pour la requête sélectionnant le film dont l'id est 34, 
       Postgres utilise l'index sur la clé primaire.

       A) :eqt:`I` Pour la base Minus, mais pas la base Magnus
       #) :eqt:`I` Pour la base Magnus, mais pas la base Minus
       #) :eqt:`C` Pour les deux

    .. eqt:: tpoptim14
       
       Regardez le plan d'exécution pour la requête ``select * from Film where id+1=35`` sur 
       la base Magnus. Que constate-t-on ?

       A) :eqt:`I` Postgres détecte correctement que la requête est équivalente à select * from Film where id=34 et utilise l'index
       #) :eqt:`C` Postgres renonce à utiliser l'index.

Algorithmes de jointure
=======================


    .. eqt:: tpoptim14
       
       Quelles sont les requêtes pour trouver le titre des films réalisés par Stanley Kubrick?

       A) :eqt:`I` select titre from Film as f, Artiste as a where nom='Kubrick'
       #) :eqt:`C` select titre from Film as f, Artiste as a where id_realisateur = a.id and nom='Kubrick'
       #) :eqt:`I` select titre from Film as f, Artiste as a where f.id = a.id and nom='Kubrick'
       #) :eqt:`C` select titre from Film where id_realisateur in (select id from Artiste where nom='Kubrick')
       #) :eqt:`C` select titre from Film where exists (select * from Artiste where id=id_realisateur and nom='Kubrick')
       #) :eqt:`C` select titre from Film as f join Artiste as a on (f.id_realisateur=a.id) where nom='Kubrick'

Copier/coller une des bonnes requêtes dans le formulaire ci-dessous, et l'exécuter. 
Vous obtiendrez le résultat dans un onglet et le plan d'exécution du SGBD (PostgreSQL) 
dans un autre. Puis répondez aux questions qui suivent : 


    .. eqt:: tpoptim15
       
       Appliquez la requête à la base Minus. Quel est l'algorithme utilisé?

       A) :eqt:`I` Boucles imbriquées simples
       #) :eqt:`I` Boucles imbriquées indexées
       #) :eqt:`C` Jointure par hachage


    .. eqt:: tpoptim16
       
       Quand on applique la requête à la base Minus, quelles sont les tables parcourues 
       séquentiellement dans ce plan?

       A) :eqt:`I` Film, mais pas Artiste
       #) :eqt:`I` Artiste, mais pas Film
       #) :eqt:`C` Film et Artiste
       #) :eqt:`I` Aucune des deux


    .. eqt:: tpoptim17
       
       Quand on applique la requête à la base Minus, sur quel attribut s'effectue 
       le hachage de la table Film ?


       A) :eqt:`I` sur l'identifiant du film
       #) :eqt:`C` sur l'identifiant du réalisateur
       #) :eqt:`I` Aucun


    .. eqt:: tpoptim18
       
       Quand on applique la requête à la base Minus, quelle est la table dite 
       "intérieure", celle stockée, après hachage, en mémoire ?

       A) :eqt:`I` Film
       #) :eqt:`C` Artiste


    .. eqt:: tpoptim19
       
       Maintenant, appliquez la requête de jointure entre Film et Artiste à la base Magnus, 
       mais sans sélection sur le nom du réalisateur (donc, sans spécifier le critère 
       "nom='Kubrick'). Quel est l'algorithme utilisé?

       A) :eqt:`I` Boucles imbriquées simples
       #) :eqt:`I` Boucles imbriquées indexées
       #) :eqt:`C` Jointure par hachage


    .. eqt:: tpoptim20
       
       Quelle est la valeur qui sert de critère d'accès pour traverser l'index utilisé?


       A) :eqt:`I` L'identifiant id de la table film
       #) :eqt:`I` L'identifiant id de la table artiste
       #) :eqt:`C` Le champ id_realisateur de la table film 




