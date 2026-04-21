
  -   Quelles informations sur l'image avant et l'image après sont exactes?
         
       .. eqt:: iavantapres

         A) :eqt:`I` L'image après ne contient que des nuplets validés par un *commit*
         #) :eqt:`C` L'image avant ne contient que des nuplets validés par un *commit*
         #) :eqt:`I` Toutes les lectures se font dans l'image avant
         #) :eqt:`I` Toutes les lectures se font dans l'image après
            
  -    Dans quel mode a-t-on besoin de conserver plus d'une version dans l'image avant?

      .. eqt:: iavantapres2

         A) :eqt:`C` En ``repeatable read`` 
         #) :eqt:`I` En ``read committed`` 
         #) :eqt:`I` En ``serializable`` 

  -    Jusqu'à quand doit-on garder une version :math:`e_i` estampillée à l'instant :math:`i`

      .. eqt:: estampilee

         A) :eqt:`I` Pour toujours
         #) :eqt:`I` Tant que la transaction qui a écrit :math:`e_i` est active
         #) :eqt:`C` Tant qu'il existe une transaction qui a débuté avant  :math:`i`
         #) :eqt:`I` Tant qu'il existe une transaction qui a déjà lu :math:`e_i`
