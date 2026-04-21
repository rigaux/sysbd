
####
BASH
####

.. code-block:: bash

    for line in $(cat tab.txt)
    do
      query="select * from "$line";"
      echo $query
    done 


.. code-block:: bash

    x=1
    while [ $x -le 5 ]
    do
      echo "Welcome $x times"
      x=$(( $x + 1 ))
    done

.. code-block:: bash
    
    var=$1 
    expr $var + 0 
    statut=$?  
    if test $statut -lt 2  
    then  
     echo "$var" numérique   
    fi 
    
    
    
.. code-block:: bash
    
    function f3
	{
  	  (( x = -x ))          
	  echo "f3 : x=$x"
	}
	
.. code-block:: bash

    function openScan
    {
      p = $R.1; # Premier bloc de R
      n = $p.1  # Rremier enregistrement dans le bloc p;
      fin = false; # Initialisation de l'indicateur de fin
    }
    