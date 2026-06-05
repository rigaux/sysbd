
  - Une transaction :math:`T_1` a lu un nuplet :math:`x` et posé un verrou partagé. Quelles affirmations
    sont vraies?

    .. eqt:: verrou1

         A) :eqt:`C` si aucun autre verrou n'est posé, :math:`T_1` peut poser un verou exclusif sur :math:`x`
         #) :eqt:`C`  :math:`T_2` peut poser un verrou partagé sur :math:`x`
         #) :eqt:`I` :math:`T_2` peut poser un verrou exclusif sur :math:`x`

  - On reprend la procédure de copie et l'exécution concurrente de deux transactions.

         .. math:: 
  
             r_1(v_1)  r_2(v_2) w_1(v_2) w_2(v_1)

    A votre avis, en appliquant un 2PL:
    
    .. eqt:: verrou2

         A) :eqt:`I` :math:`T_1` s'exécutera avant :math:`T_2`
         #) :eqt:`I`  :math:`T_2` s'exécutera avant :math:`T_1`
         #) :eqt:`C` un interblocage surviendra?

  - On exécute en concurrence deux transactions de réservation, par le même client mais 
    pour deux spectacles différents:
  
    .. math::

        r_1(s_1)  r_1(c) r_2(s_2)  r_2(c)  w_2(s_2)  w_2(c) C_2 w_1(s_1) w_1(c) C_1
    
    Quelle opération à votre avis entraînera le premier blocage d'une transaction ?
    
    .. eqt:: verrou2

         A) :eqt:`I` sur :math:`r_2(c)`
         #) :eqt:`I`  :math:`w_2(s_2)`
         #) :eqt:`C` :math:`w_2(c)` 
