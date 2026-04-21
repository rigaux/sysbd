$$r_1(c_1) r_1(c_2)  Res(c_2, s, 2)  \ldots r_1(c_n) r_1(s)$$

Supposons qu\'un hôpital gère la liste de ses médecins dans une table
(simplifiée) *Docteur(nom, garde)*, chaque médecin pouvant ou non être
de garde. On doit s\'assurer qu\'il y a toujours au moins deux médecins
de garde. La procédure suivante doit permettre de placer un médecin au
repos en vérifiant cette contrainte.

``` {.sql}
/* Une procédure de gestion des gardes */

create or replace procedure HorsGarde (nomDocteur VARCHAR) AS

 -- Déclaration des variables
 val nb_gardes;  

 BEGIN
   -- On calcule le nombre de médecin de garde
   SELECT count(*) INTO nb_gardes FROM Docteur WHERE nom = nomDocteur;

   IF (nb_gardes > 2) THEN
      UPDATE Docteur SET garde = false WHERE nom = nomDocteur;
      COMMIT;
   ENDIF
END;
/
```

En principe, cette procécure semble très correcte (et elle l\'est).
Supposons que nous ayons trois médecins, Philippe, Alice, et Michel,
désignés par *p*, *a* et *m*, tous les trois de garde. Voici une
exécution concurrente de deux transactions $T_1$ =
*HorsGarde(\'Philippe\')* et $T_2$ = *HorsGarde(\'Michel\')*.

$$r_1(p)  r_1(a) r_1(m) r_2(p)  r_2(a) r_2(m) w_1(p) w_2(m)$$

Questions:

> -   Quel est avec cette exécution le nombre de médecins de garde
>     constatés par $T_1$ et $T_2$
>
>     ::: {.eqt}
>     garde1
>
>     A)  `I`{.interpreted-text role="eqt"} 3 pour $T_1$, 2 pour $T_2$
>     B)  `C`{.interpreted-text role="eqt"} 3 pour $T_1$, 3 pour $T_2$
>     C)  `I`{.interpreted-text role="eqt"} 2 pour $T_1$, 3 pour $T_2$
>     :::
>
> -   Quel est le nombre de médecins de garde à la fin?
>
>     ::: {.eqt}
>     garde2
>
>     A)  `I`{.interpreted-text role="eqt"} 2
>     B)  `C`{.interpreted-text role="eqt"} 1
>     C)  `I`{.interpreted-text role="eqt"} 0
>     :::
>
> -   Conclusion? Vous pouvez vérifier la sérialisabilité (conflits,
>     graphes) et appliquer le contrôle de concurrence multi-versions
>     pour vérifier s\'il détecte et prévient les anomalies de cette
>     exécution.
