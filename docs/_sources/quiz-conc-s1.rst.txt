

  - Supposons une table *T(id, valeur)*, et la procédure suivante qui
    copie la valeur d'une ligne vers la valeur d'une autre:
    
    .. code-block:: sql

       /* Une procédure de copie */

       create or replace procedure Copie (id1 INT, id2 INT) AS

        -- Déclaration des variables
        val INT;  

        BEGIN
          -- On recherche la valeur de id1
          SELECT * INTO val FROM T WHERE id = id1

          -- On copie dans la ligne id2
          UPDATE T SET valeur = val WHERE id = id2
          
          -- Validation
          commit; 
       END;
      /

    On prend deux transactions *Copie(A, B)* et *Copie(B,A)*, l'une copiant de la
    ligne *A* vers la ligne *B* et l'autre effectuant la copie inverse. Initialement, la
    valeur de *A* est *a* et la valeur de *B* est *b*. Qu'est-ce qui
    caractérise une exécution sérialisable de ces deux transactions?
       
    .. eqt:: defSerial1

       A) :eqt:`I` *A* et *B* valent *a*
       #) :eqt:`I` *A* et *B* valent *b*
       #) :eqt:`C` *A* et *B* ont la même valeur
       #) :eqt:`I` *A* vaut *b* et  *B* vaut  *a*

  -  Voici une exécution concurrente de deux transactions de réservation.
         
          .. math:: 
  
               r_1(s)  r_1(c_1) w_1(s) r_2(s) r_2(c_2) w_2(s) w_1(c_1) w_2(c_2)

      Quelles sont les opérations en conflit?

      .. eqt:: conflitTrans1


         A) :eqt:`I` :math:`r_1(s)` et :math:`r_2(s)`
         #) :eqt:`C` :math:`r_1(s)` et :math:`w_2(s)`
         #) :eqt:`C`:math:`w_1(s)` et :math:`w_2(s)`
         #) :eqt:`I`:math:`r_2(c_2)` et :math:`w_2(c_2)`

  -   Voici une exécution concurrente de *Copie(A, B)* et *Copie(B,A)*
         
         .. math:: 
  
             r_1(v_1)  r_2(v_2) w_1(v_2) w_2(v_1)

      Est-elle sérialisable, d'après les conflits et le graphe? 
      
      .. eqt:: serial2

         A) :eqt:`I` Oui
         #) :eqt:`C` Non
            
      Initialement, la valeur de *A* est *a* et la valeur de *B* est *b*? 
      Quel est l'état de la base à la fin ?

      .. eqt:: serial3

         A) :eqt:`C` *A* vaut *b* et  *B* vaut  *a*
         #) :eqt:`I` *A* vaut *a* et  *B* vaut  *b*
         #) :eqt:`I` *A* vaut *b* et  *B* vaut  *b*
         #) :eqt:`I` *A* vaut *b* et  *B* vaut  *b*

