.. _chap-annales:
   
###################
Annales des examens
###################

**************************************************
Examen blanc du 20 janvier 2020 (sans concurrence)
**************************************************


Stockage et indexation
======================

On veut stocker un fichier *F* avec 120000 enregistrements d'une taille fixe de 
100 octets par article.

Questions :

  - De combien de blocs a-t-on besoin au minimum pour  stocker tout
    le fichier si la taille d'un bloc est 8192 octets, sachant
    que chaque bloc contient un entête de 150 octets
    et qu'un enregistrement ne peut pas chevaucher 2 blocs?

   .. ifconfig:: annales_2020_1 in ('public')

      .. admonition:: Correction
      
           Un bloc contient 8 042 octets utiles. Donc 80 enregistrements
           par bloc au maximum. On divise les 120 000 enregistrements par 80 
           et on obtient 1 500 blocs

  - On suppose maintenant que *F* est indexé par un index non dense 
    sur ``A``  et  un index dense sur un autre champ ``B``. On peut
    stocker 100 entrées dans un bloc d'index et aucune place libre n'est laissée dans les blocs. 
    Combien d'entrées y a-t-il dans les feuilles de l'index non dense? 
    dans les feuilles de l'index dense? 

   .. ifconfig:: annales_2020_1 in ('public')

      .. admonition:: Correction

          Le fichier *F* contient 1 500 blocs et et trié sur ``A``.
          L'index non dense contient donc 1500 entrées, une par bloc et cet index occupe 15
          blocs. L'index dense 
          contient 120000 entrées, une par enregistrement, et occupe 1200 blocs..

  - Supposons que l'index non dense a deux niveaux, racine
    comprise, et que seule la racine est en mémoire.  On se place dans le pire
    des cas où il faut une lecture physique  pour lire une feuille d'index et une autre pour
    lire un bloc du fichier. 
    
    On cherche les enregistrements pour lesquels la
    valeur de l'attribut  ``A`` est comprise entre P1A3 et P3G5. On
    suppose qu'il y a moins de 100 enregistrements tels que ``A``
    commençe par P. Combien de lectures coûte la recherche par l'index dans le pire
    des cas?

   .. ifconfig:: annales_2020_1 in ('public')

      .. admonition:: Correction

          La recherche utilise  l'index non dense sur ``A``. Celui-ci tient sur 15 blocs. 
          La traversée de l'index part de la racine et arrive immédiatement à la feuille 
          d'index dont la 
          première entrée est inférieure ou égale à P1A3 et dont la dernière entrée est 
          supérieure ou égale à P1A3. On recherche dans cette feuille l'entrée la plus grande 
          inférieure ou égale à P1A3. Cette entrée contient l'adresse du bloc du fichier qui 
          contient l'article de code  P1A3.  On accède à ce bloc bloc. 
          Les articles sont triés sur ``A``. 
          Soit tous les articles de code compris entre P1A3 et P3G5 sont dans ce bloc soit ils sont
          à cheval sur deux blocs adjacents (ils ne peuvent pas être sur plus de 2 blocs
          adjacents). Dans ce dernier cas, une lecture du bloc
          adjacent chaîné est nécessaire. Donc la recherche coûte 2 ou 3 accès bloc.

  - Même question avec l'index dense, pour une recherche sur l'attribut
    ``B``.

   .. ifconfig:: annales_2020_1 in ('public')

      .. admonition:: Correction

          La recherche utilise  l'index non dense sur ``B``. La  différence essentielle 
          est que le parcours séquentiel s'effectue *au niveau des feuilles de l'index*.
          Il n'est plus possible de le faire sur le fichier car ce dernier n'est plus
          trié. 
          
          Pour chaque entrée trouvée dans une feuille, il faut effectuer une lecture de bloc
          dans le fichier de données. Au pire, il faut lire autant de blocs que
          d'enregistrements, soit 100 lectures qui viennent s'ajouter aux deux blocs
          lus dans l'index. Le coût prédominant est donc dans ce cas la multiplication
          des accès aléatoires au fichier de données, ce qui montre une nouvelle fois
          qu'une recherche par intervalle avec un index peut s'avérer contre-performante.

Index et optimisation
=====================

Soit les tables relationnelles suivantes (les attributs qui forment 
une clé sont en gras):

  - Produits  (**code**, marque, desig, descr). NB:  code : identifiant du produit, marque : marque du produit,
    desig : désignation du produit, descr : description.
  - PrixFour (**code, nom**, prix). NB: code : code du produit, nom : nom du fournisseur.
  - NoteMag    (**code, titre**, note). NB: code : code du produit,  titre : titre du magazine,
    note : note entre 1 et 10 du produit dans le magazine)

Voici une instance de la table NoteMag.


    .. csv-table:: 
       :header: "Code", "Titre", "Note"
       :widths: 10, 10, 10
       
       'A345', 'HIFI' ,  8
        'P123' , 'Audio Expert' , 6
        'X254' , 'HIFI' , 7
        'K783' , 'Son & Audio',   3
        'P345' , 'HIFI' , 6
        'P512' , 'Audio Expert' , 8
        'L830' , 'Audio Expert' , 8
        'M240' , ''HIFI'' , 6

La table occupe plusieurs blocs  dont chacun peut contenir au maximum 3
n-uplets.

 - Construire un arbre B+ sur l'attribut ``code``, 
   avec 4 entrées par bloc au maximum.
 - Est-il utile d'indexer l'attribut ``titre``? Pourquoi?
 - Soit la requête suivante :
  
    .. code-block:: sql

         select *
         from NoteMag
         where code between 'A000' and 'X000';

   Pour évaluer cette requête, on suppose que le tampon de lecture ne peut
   contenir qu'un seul bloc et l' index tient en mémoire. Dans ce cas, est-ce
   qu'il est préférable d'utiliser l'index ou de parcourir la table
   séquentiellement ? Pourquoi ?


   .. ifconfig:: annales_2020_1 in ('public')

      .. admonition:: Correction
      
          Une lecture séquentielle est préférable : la sélectivité de l'index 
          est très basse, et comme il s'agit d'un index dense, on risque de lire la même
          bloc plusieurs fois.

On donne ci-dessous une requête SQL et le plan d'exécution fourni par Oracle :

.. code-block:: sql

   select desig, marque, prix
   from Produits, PrixFour, NoteMag
   where Produits.code=PrixFour.code
   and Produits.code=NoteMag.code
   and note > 8;

Plan d'exécution :

.. code-block:: text

   0 SELECT STATEMENT
      1 MERGE JOIN
         2 SORT JOIN
            3 NESTED LOOPS
               4 TABLE ACCESS FULL NOTEMAG
               5 TABLE ACCESS BY INDEX ROWID PRODUITS
                  6 INDEX UNIQUE SCAN A34561
         7 SORT JOIN
            8 TABLE ACCESS FULL PRIXFOUR

Questions:

  - Existe-t-il un index ? sur quel(s) attribut(s) de quel(s) table(s) ?

    .. ifconfig:: annales_2020_1 in ('public')

        .. admonition:: Correction
      
          Il existe un index sur l'attribut code de la table Produits.

  - Algorithme de jointure : Expliquer en détail le plan d'exécution (accès
    aux tables, sélections, jointure, projections) 

  - Ajout d'index : On crée un index sur l'attribut ``note``  de la table 
    ``NoteMag``. Expliquez les améliorations en
    terme de plan d'exécution apportées par la création de cet index.

  .. ifconfig:: annales_2020_1 in ('public')

      .. admonition:: Correction
      
          Après création d'index le plan est :

         .. code-block:: text

            Plan d'execution
            ----------------
            0 SELECT STATEMENT
              1 NESTED LOOPS
                2 NESTED LOOPS
                  3 TABLE ACCESS FULL PRIXFOUR
                  4 TABLE ACCESS BY INDEX ROWID PRODUITS
                    5 INDEX UNIQUE SCAN PRODUITS_CODE
                6 TABLE ACCESS BY INDEX ROWID NOTEMAG
                  7 INDEX RANGE SCAN NOTE_MAG


**********************
Examen blanc juin 2020
**********************

On prend pour exemple une base de données 
qui sert à la gestion d'un site web de diffusion de la musique en *streaming*:

  - Abonné (id, nom, prénom, typeAbonnement, dateDébut)
  - Artiste (id, nom, prénom, nationalité)
  - Album (id, nom, idArtiste, annéeSortie)
  - Chanson (id, nom, idAlbum)
  - Ecoute (idAbonné, idChanson, date, téléchargé)

L'abonnement est sans engagement: seulement la date de début est nécessaire pour 
un abonnement en cours. Le type d'un abonnement peut être: 
'free' (financé par la publicité), 'normal' et 'premium' 
(donne le droit de télécharger la musique en local pour une écoute 
hors connexion). L'attribut 'téléchargé' vaut vrai ou faux. 
Un abonné peut avoir écouté une chanson plusieurs fois (à des dates différentes).

Le SGBD crée un index sur les clés primaires, mais pas sur les clés étrangères.

Questions sur le schéma (3 points)
==================================

  - Pour la table Ecoute,  
    identifiez les clés primaires et étrangères.


  .. ifconfig:: annales_2020_2 in ('public')

      .. admonition:: Correction
      
           - Clé primaire: (idAbonné, idChanson, date)
           - Clés étrangères: idAbonné, idChanson
           
  - Donnez la commande SQL pour créer la table Ecoute.

    .. ifconfig:: annales_2020_2 in ('public')

      .. admonition:: Correction
      
         .. code-block:: sql

            create table Ecoute(
                idAbonné integer,
                idChanson integer,
                date DATE,
                téléchargé BOOLEAN,
                PRIMARY KEY (idAbonné, idChanson, date)
                FOREIGN KEY (idAbonné) REFERENCES Abonné(id),
                FOREIGN KEY (idChanson) REFERENCES Chanson(id))

  - Une recherche par index est-elle possible si on interroge la table Ecoute sur l'id
    d'une chanson (justifier)?
  - Une recherche par index est-elle possible si on interroge la table Ecoute sur l'id
    d'un abonné (justifier)?


Stockage et indexation (4 points)
=================================


On insère successivement les enregistrements suivants dans la table Artiste, selon cet ordre :


    .. csv-table:: 
       :header: "Id", "Nom", "Prénom", "Nationalité"
       :widths: 4, 10, 10, 10
       
        1 , Moustaki , Georges , française
        2 , Modja , Inna , malienne 
        3 , LeForestier , Maxime , française
        4 , Vian , Boris , française
        5 , DePalmas , Gérald , française
        6 , June , Valérie , américaine
        7 , Higelin, Jacques,française 
        8 , Berger , Michel , française
        9 , Goldman , Jean-Jacques , française
        10 , Mitchell , Eddy , française
        11 , Katerine , Philippe , française
        12 , Estefan , Gloria , cubaine
        13 , Marley , Bob , jamaicaine
        14 , Azrié  , Abed , française

On met en place un index sur l'attribut ``nom`` de cette table. 

  - Construire l'arbre B d'ordre 2 (4 entrées max par bloc) correspondant à cet ensemble d'enregistrements, 
    en respectant l'ordre d'insertion. Donner les étapes de construction 
    intermédiaires importantes (celles qui produisent un changement de la structure de l'arbre). 

  - On considère que cet arbre B est stocké à raison d'un nœud 
    par bloc sur disque. On recherche les noms des artistes dont 
    l'initiale du nom se trouve entre 'B' et 'I' (inclus). 
    Combien de blocs disque doivent être chargées au minimum pour répondre 
    à cette requête en utilisant l'arbre B+ ? Justifier. 

    .. ifconfig:: annales_2020_2 in ('public')

      .. admonition:: Correction

            .. _arbreb-blanc-juin20:
            .. figure:: ../figures/arbreb-blanc-juin20.png
                :width: 90%
                :align: center
   
      Deux graphes simples

            Il s'agit ici d'une requête par intervalle, facilement réalisable avec un arbre B. 
            On commence par faire une recherche du premier enregistrement dont 
            l'initiale du nom est égale ou immédiatement supérieure à 'B'. 
            On a trouvé le premier enregistrement répondant à la requête 
            (en parcourant ici 3 feuilles de l'arbre B), il suffit 
            d'exploiter le chaînage des feuilles pour trouver les autres enregistrements 
            (en parcourant ici encore 2 feuilles de l'arbre B). On 
            charge donc 5 blocs d'index. Il faut ensuite récupérer 
            les données pointées par l'index sur disque. Au mieux, toutes 
            les données sont stockées dans une même bloc (peu probable mais 
            possible...). Donc on charge au minimum 6 blocs.

Optimisation (7 points)
=======================

Soit la requête suivante:

.. code-block:: sql

     select Album.nom
     from Artiste, Album
     where Artiste.id=Album.idArtiste
     and Artiste.nom='Moustaki'

Questions:

  - Donnez le plan d'exécution sous la forme de votre choix, en supposant 
    que les seuls index sont ceux sur les clés primaires
  - Qu'est-ce qui change si on crée l'index sur le nom des artistes?
  
Soit maintenant le plan d'exécution suivant:

.. code-block:: text

            0 SELECT STATEMENT
                1*   MERGE JOIN
                2      SORT JOIN
                3*        NESTED LOOPS
                4*          TABLE ACCESS FULL           Ecoute
                5           TABLE ACCESS BY ROWID       Chanson
                6              INDEX RANGE SCAN         IDX-Chanson_ID
                7      SORT JOIN
                8         TABLE ACCESS FULL             Album

                1 - access(Chanson.id_album=Album.id)
                3 - access(Ecoute.id_chanson=Chanson.id)
                4 - access(date=29/05/2013)

Questions:

  - Donnez la requête correspondante
  - Expliquez ce plan, en indiquant notamment quels index existent, et lesquels
    n'existent pas

    .. ifconfig:: annales_2020_2 in ('public')


      .. admonition:: Correction


        .. _pex-blanc-juin20:
        .. figure:: ../figures/pex-blanc-juin20.png
            :width: 90%
            :align: center

        L'index sur Ecoute(idAbonne) ne sert à rien dans cette requête. Les deux index suivants 
        peuvent être utilisés pour la jointure entre Chanson et Ecoute 
        (donc boucles imbriquées avec index) mais pas tous les deux en même temps, 
        il faut choisir l'un des deux (les deux options sont acceptées ici). 
        Ensuite tri-fusion ou boucles-imbriquées acceptés pour la seconde jointure 
        (dépend de la taille des tables). Ci-dessous, un tri-fusion pour la seconde jointure.

        .. code-block:: sql

            select idAbonne, Album.nom
            from Ecoute, Chanson, Album
            where Ecoute.id_chanson = Chanson.id
            and Chanson.id_album = Album.id
            and date='29/05/2013';

  - Quels index pouvez-vous ajouter pour optimiser cette requête, et quel est le plan d'exécution
    correspondant?

    .. ifconfig:: annales_2020_2 in ('public')

        .. admonition:: Correction

            L'index sur Album(id) est utilisé pour la seconde jointure qui devient donc une jointure 
            par boucles imbriquées avec index. L'index sur Ecoute(date) n'est pas utilisé pour 
            la jointure entre Ecoute et Chanson mais pour effectuer une sélection des 
            enregistrements sur la table directrice Ecoute dans la première jointure.


            .. code-block:: text

                0 SELECT STATEMENT
                1*    NESTED LOOPS
                2*        NESTED LOOPS
                3            TABLE ACCESS BY ROWID       Ecoute
                4*             INDEX RANGE SCAN          IDX-Ecoute_DATE
                5            TABLE ACCESS BY ROWID       Chanson
                6              INDEX RANGE SCAN          IDX-Chanson_IDChanson
                7         TABLE ACCESS BY ROWID          Album
                8              INDEX RANGE SCAN          IDX_Album_ID

Concurrence (6 points)
======================


Soit l'exécution concurrente suivante :

.. math::

    H = r_2[x] r_3[x] w_1[y] r_3[y] w_3[y] r_1[z] w_2[y] c_1 w_3[z] w_2[z] c_3 c_2

Questions

  - Donner la liste des conflits de H 
  - Donner le graphe de sérialisation de H. Que pouvez-vous déduire de ce graphe ?
  - Donner l'exécution  finale obtenue par application de l'algorithme de verrouillage 
    à deux phases. Donner le détail du déroulement de l'algorithme. 
  - Que se passerait-il si on ne posait que des verrous exclusifs?

    .. ifconfig:: annales_2020_2 in ('public')

        .. admonition:: Correction

			- Réponses:
			
			   -  Sur x :  aucun conflit
			   - Sur y :  :math:`w_1[y] r_3[y]`, :math:`w_1[y] w_3[y]`, :math:`r_3[y] w_2[y]`, 
			     :math:`w_1[y] w_2[y]` et :math:`w_3[y] w_2[y]`
			   - Sur z :  :math:`r_1[z] w_2[z]`,  :math:`r_1[z] w_3[z]`, :math:`w_3[z] w_2[z]`

			- :math:`T_1 \rightarrow T_3, T_3 \rightarrow T_2, T_1 \rightarrow T_2`. 
			  Il n'y a pas de cycle, dont H est *sérialisable*.
			- Exécution finale:
			
			  .. math::
			    
			      H' =  r_2[x] r_3[x] w_1[y] r_1[z] c_1 r_3[y] w_3[y] w_3[z] c_3 w_2[y] w_2[z] c_2
			- Si on ne pose que des verrous exclusifs (par exemple avec la clause ``for update``), 
			  :math:`r_3[x]` (donc :math:`T_3`) est bloqué par  :math:`T_2` qui a effectué :math:`r_2[x]`.
			  :math:`T_3` doit attendre la fin des deux autres transactions pour reprendre.

****************
Examen juin 2022
****************

Stockage et indexation (6 points)
=================================

Voici le contenu d'un fichier  ``animaux``:

.. code-block:: text

	(jaguar, 17), (chameau, 22), (gnou, 1), (girafe, 13), (chat, 3),
	(lion, 8), (dauphin, 40), (zèbre, 11), (hamster, 6), (hyène,9),
	(licorne, 2), (babouin, 12), (piranha,55), (saumon, 82), (bar,44), 
	(anguille, 43), (gorille,98), (tigre,76), (requin, 56), (escargot,45).


On suppose que l'on peut placer  2 enregistrements par bloc. 

 - On veut construire un index non-dense sur le premier attribut.
   Que faut-il faire au préalable ? Donnez les différents niveaux de l'index.
 
 - Construire un arbre B sur le second attribut, 
   en supposant 2 enregistrements et trois pointeurs par bloc *au maximum*.

 - On dispose des deux index ci-dessus. Quel est le 
   nombre d'entrées/sorties *dans le pire des cas*
   pour la recherche des animaux dont le nom commence par un 'g',
   et pour la recherche des animaux dont l'identifiant est compris
   entre 40 et 50 (prendre en compte les accès à l'index *et*
   au fichier).

 - On veut trier ce fichier (tel qu'il est donné dans l'énoncé)
   avec seulement 3 blocs, toujours
   en supposant qu'on peut placer deux enregistrements par bloc.
   Décrivez le déroulement de l'algorithme de tri-fusion, 
   et donnez le nombre total d'entrées/sorties, sans compter
   l'écriture finale du fichier trié. 


.. ifconfig:: annales_2022 in ('public')

    .. admonition:: Correction
 
 
		- Il faut d'abord trier le fichier:
		
		  .. code-block:: text

				(anguille, 43),  (bar, 44), (babouin, 12), (chameau, 22),  
				(chat, 3), (dauphin, 40),  (escargot,44),
				(girafe, 13), (gnou, 1),  (gorille,98), 
				(hamster, 6), (hyène,9), (jaguar, 17),  
				(licorne, 2),  (lion, 8),   (piranha,55), (saumon, 82),  (requin, 56),
				(tigre,76), (zèbre, 11),

		  Ensuite on groupe par 2 et on crée le premier niveau d'index:

		  .. code-block:: text
		  
			anguille -- babouin -- chat -- escargot -- gnou -- hasmter --
			jaguar -- lion -- saumon -- tigre

		  Encore une fois:

		  .. code-block:: text
		  
				anguille --  chat --  gnou -- jaguar -- saumon 
	
		  Puis

		  .. code-block:: text
		  
				anguille --   gnou -- saumon 

		  Et finalement il reste ``(anguille, saumon)`` à la racine, soit 4 niveaux.

		- Standard.

		- La première recherche doit ramener trois enregistrements. 
		  Dans le cas de l'index non-dense, le fichier est trié.
		  On peut donc parcourir séquentiellement à partir du
		  premier 'g'. On lit donc 4 blocs dans l'index pour arriver aux feuilles, 
		  puis 2 blocs en parcours séquentiel.
		  
		  Les enregistrements ne sont pas ordonnés pour l'arbre B. Il faut donc, après le
		  parcours d'index, parcourir les feuilles pour les valeurs de clé entre 40 et 50,
		  avec une lecture de bloc (au pire) pour chacune.

		- On utilise 2 blocs pour l'entrée, un pour la sortie. Dans
		  les 2 blocs on place 4 enregistrements. Il y a 20 animaux
		  donc (1) 5 fragments initiaux de 2 blocs, puis (2)
		  2 fragments de 4 blocs, et
		  un  fragment de 2 blocs, puis (3) un fragment de 8 blocs et un  de deux.
		  Et on termine par une lecture. Donc coût = :math:`3 \times 2 \times 10 + 10 = 70`.
		  Plus subtil: on peut utiliser 3 blocs pour la phase de tri, et diviser la mémoire
		  en 2+1 seulement pour la phase de fusion.


Jointures et optimisation (9 points)
====================================

On considère trois relations 
:math:`R(\textbf{a},b,d)`, :math:`S(\textbf{c},d,e)` et :math:`T(\textbf{e},f)` dont les clés
primaires sont respectivement :math:`a`, :math:`c` et :math:`e`.
:math:`R` contient 200 000 enregistrements, :math:`S`  20 enregistrements et :math:`T` 500 enregistrements. Des index
sont créés sur les clés primaires, et on suppose que
pour chaque relation, y compris celles qui sont calculées par une jointure,
on stocke 10 enregistrements par bloc.

On suppose que tous les index sont toujours en mémoire principale
(donc pas d'entrée/sortie pour les accès aux index).
On dispose de 20 blocs en mémoire pour traiter les jointures.
Les jointures se font sur les attributs de même nom.

 - Quel est le nombre maximal
   d'enregistrements dans :math:`S \Join T` (indiquez également la condition 
   pour que ce nombre maximal soit atteint) ? Quelle est la clé de la
   relation obtenue ?

 - Mêmes questions pour :math:`R \Join S \Join T`.

 - Décrire le fonctionnement de l'algorithme par boucles 
   imbriquées pour calculer :math:`S \Join T`, en exploitant au mieux la
   mémoire disponible. 
   Indiquez le coût en entrées/sorties pour cet algorithme.

 - Même question l'algorithme par boucles 
   imbriquées *indexées*.
   
 - Décrire un plan d'exécution  
   pour calculer :math:`R \Join S \Join T`\ et 
   évaluer son coût (nombre de blocs lus).
    
 - Une application a inséré des enregistrements dans :math:`S`
   qui en contient maintenant 5 000. Le
   SGBD gère un histogramme qui indique que la sélectivité
   de l'attribut :math:`d` est 5 (autrement dit, une sélection 
   sur :math:`R` ou :math:`S` pour une valeur de :math:`d` ramène 5\% des enregistrements).
   Quelle taille peut-on estimer pour :math:`R \Join S` ?

 - Je n'ai toujours que 20 blocs en mémoire.
   Décrire l'algorithme de jointure par hachage pour :math:`R \Join S` 
   et évaluer son coût.


.. ifconfig:: annales_2022 in ('public')

    .. admonition:: Correction

		- Il y a au plus 20 enregistrements, et il faut pour l'atteindre
		  que la clé étrangère soit ``not null``,
		  et le respect de l'intégrité référentielle de :math:`S` vers :math:`T`. La clé
		  est :math:`c` (il y a dépendance fonctionnelle de :math:`c`  vers :math:`e`).
		  
		- Dans le pire des cas il y a :math:`200~000 \times 20` enregistrements
		  (s'il y a une seule valeur pour :math:`d`).

		- On met :math:`S` en mémoire (donc 2 blocs) et on l'organise
		  comme une table de hachage sur l'attribut :math:`S.e`. Puis on lit :math:`T` séquentiellement (50 blocs),
		  en cherchant pour chaque enregistrement :math:`(e_i,f_i)` de :math:`T` le ou les
		  enregistrements correspondant dans la table de hachage.
		  
		  Coût ,: 52 blocs.
   
		- On parcourt :math:`S` séquentiellement (2 blocs), pour chaque enregistrement
		  :math:`(c, d,e)` (il y en a 20), on utilise l'index pour accéder à :math:`T`. Pour chaque entrée
		  trouvée dans l'index il faut lire un bloc (au pire) sur le disque.
		  
		  Coût ,: 2 + 20 blocs. 

		- On constate qu'il n'existe pas d'index disponible 
		  pour la jointure avec :math:`R`, car la clé primaire de :math:`R` ne se trouve
		  en tant que clé étrangère ni dans :math:`S` ni dans :math:`T`.
		  
		  L'algorithme : on évalue  :math:`S \Join T`, comme indiqué précemment. 
		  Il faut ensuite choisir un algorithme de jointure sans index.
		  Etant donnée la petite taille de :math:`S \Join T`, on choisit
		  la jointure par boucles imbriquées. On construit une table de hachage en mémoire sur le résultat de :math:`S \Join T`
		  (2 blocs au maximum, clé de hachage : :math:`d`) ; on lit séquentiellement :math:`R` 
		  en joignant chaque enregistrement avec la table de hachage. 
		  
		  La lecture de :math:`R` est prédominante : 20 000 blocs à lire séquentiellement.
		  
		  Toutes les autres possibilités sont moins bonnes, à cause de la taille
		  du résultat de la jointure entre :math:`R` et une autre table. Penser par exemple
		  au coût qui résulterait d'un tri préalable de :math:`R` sur l'attribut :math:`d` pour
		  une jointure par tri-fusion.
          
		- Pour chaque tuple de :math:`R`, on trouve :math:`5000 \times 0,05 = 250`
		  enregistrements dans :math:`S`: 50 M de enregistrements au final.

		- Jointure par hachage : je hache :math:`S` en 25 fragments de 
		  200 enregistrements chacune (20 blocs en mémoire). Ensuite je hache :math:`R` en 2
		  fragments également (leur taille m'importe peu). Puis je fais la jointure
		  entre chaque paire de fragmentss. Coût (très 	approximatif) =
		  :math:`3 \times (|S| + |R|) = 3 \times (20 000 + 500) = 61 500`.

Concurrence (6 points)
======================

On considère le système d'information
d'un institut de sondage, avec les tables relationnelles 
suivantes (les attributs ou combinaisons d'attributs qui forment 
une clé unique sont **en gras**).

 - Personne (**numPers**, nom, sexe, numCat)
 - Question (**numQ**, description)
 - Avis (**numQ, numPers**, reponse)


L'exécution suivante est reçue par le système de l'institut de sondage :

.. math::

        H : r_1[x] r_2[y] w_1[x] r_3[y]  r_2[x] w_3[y] r_2[z] C_1 r_3[z] w_2[z] C_2 w_3[z] C_3

Répondez aux questions suivantes sur :math:`H`. 

  - Parmi les programmes qui s'exécutent dans le système, 
    il y a ``ModifierAvis(nomPers, numQuestion, nouvelle_réponse)``,  qui modifie
    la réponse donnée par
    la personne ``nomPers`` à  la question ``numQuestion`` 
    en ``nouvelle\_réponse`` 
   
    Si les enregistrements de :math:`H` sont des nuplets des relations de la base 
    de données, montrez (en justifiant votre réponse) 
    quelles transactions de :math:`H` pourraient provenir de ``ModifierAvis``.
   
  - Vérifiez si :math:`H` est sérialisable en identifiant 
    les conflits et en construisant le graphe de sérialisation.
  - Montrer qu'il existe des lectures sales, 
    et expliquez les conséquences possibles.
  - Quelle est l'exécution obtenue par verrouillage 
    à deux phases à partir de :math:`H`? 
  - (**Question bonus, pour 2 points**). Quelle est l'exécution obtenue avec
    l'algorithme de concurrence par versionnement ?
    On suppose que toutes les transactions débutent
    au même moment.


.. ifconfig:: annales_2022 in ('public')

    .. admonition:: Correction
    
		- Les transactions sont :math:`T_1 = r_1[x] w_1[x]`, :math:`T_2 = r_2[y] r_2[x] r_2[z] w_2[z]`,
		  :math:`T_3 = r_3[y] w_3[y] r_3[z] w_3[z]`  
		  
		  ``ModifierAvis`` doit lire un avis et 
		  le modifier. On peut donc considérer qu'il s'agit de :math:`T_1`. :math:`T_2`
		  est également une possibilité, en supposant qu'on lit d'abord la personne
		  puis la question.
		-- Les conflits sont: :math:`w_1[x] \to r_2[x]`,  :math:`r_2[y] \to w_3[y]`,
		   :math:`r_3[y] \to w_2[z]`  et :math:`w_2[z] \to w_3[z]`.  On trouve un cycle
		   :math:`T_2`  et :math:`T_3`  donc :math:`H` n'est pa sérialisable. 
		- :math:`r_2[x]` est une lecture sale (car précédée de :math:`w_1[x]`). 
		  Si :math:`T_1` s'interrompt avant le ``commit``, la valeur
		  lue par :math:`r_2[x]` n'existera plus et :math:`T_2`  risque de 
		  valider un état incohérent.
		  
		- Après verrouillage à deux phases, on obtient :
		
		  .. math::
		  
		     r_1[x] r_2[y] w_1[x] r_3[y] (T_2 \ \rm{attente\ sur }\ r_2[x]) (T_3\ \rm{\ attente\ sur\ }w_3[y]) C_1 r_2[x] r_2[z] w_2[z] C_2 w_3[y] r_3[z] w_3[z] C_3
		     
		- Avec l'algo de versionnement, on rejette :math:`w_3[z]` 
		  car l'écriture :math:`w_2[z]` est intervenue entre-temps.