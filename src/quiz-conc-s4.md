> -   Une transaction $T_1$ a lu un nuplet $x$ et posé un verrou
>     partagé. Quelles affirmations sont vraies?
>
>     ::: {.eqt}
>     verrou1
>
>     A)  `C`{.interpreted-text role="eqt"} si aucun autre verrou n\'est
>         posé, $T_1$ peut poser un verou exclusif sur $x$
>     B)  `C`{.interpreted-text role="eqt"} $T_2$ peut poser un verrou
>         partagé sur $x$
>     C)  `I`{.interpreted-text role="eqt"} $T_2$ peut poser un verrou
>         exclusif sur $x$
>     :::
>
> -   On reprend la procédure de copie et l\'exécution concurrente de
>     deux transactions.
>
>     > $$r_1(v_1)  r_2(v_2) w_1(v_2) w_2(v_1)$$
>
>     A votre avis, en appliquant un 2PL:
>
>     ::: {.eqt}
>     verrou2
>
>     A)  `I`{.interpreted-text role="eqt"} $T_1$ s\'exécutera avant
>         $T_2$
>     B)  `I`{.interpreted-text role="eqt"} $T_2$ s\'exécutera avant
>         $T_1$
>     C)  `C`{.interpreted-text role="eqt"} un interblocage surviendra?
>     :::
>
> -   On exécute en concurrence deux transactions de réservation, par le
>     même client mais pour deux spectacles différents:
>
>     $$r_1(s_1)  r_1(c) r_2(s_2)  r_2(c)  w_2(s_2)  w_2(c) C_2 w_1(s_1) w_1(c) C_1$$
>
>     Quelle opération à votre avis entraînera le premier blocage d\'une
>     transaction ?
>
>     ::: {.eqt}
>     verrou2
>
>     A)  `I`{.interpreted-text role="eqt"} sur $r_2(c)$
>     B)  `I`{.interpreted-text role="eqt"} $w_2(s_2)$
>     C)  `C`{.interpreted-text role="eqt"} $w_2(c)$
>     :::
