---
title: BASH
---

``` {.bash}
for line in $(cat tab.txt)
do
  query="select * from "$line";"
  echo $query
done 
```

``` {.bash}
x=1
while [ $x -le 5 ]
do
  echo "Welcome $x times"
  x=$(( $x + 1 ))
done
```

``` {.bash}
var=$1 
expr $var + 0 
statut=$?  
if test $statut -lt 2  
then  
 echo "$var" numérique   
fi 
```

``` {.bash}
function f3
{
  (( x = -x ))          
  echo "f3 : x=$x"
}
```

``` {.bash}
function openScan
{
  p = $R.1; # Premier bloc de R
  n = $p.1  # Rremier enregistrement dans le bloc p;
  fin = false; # Initialisation de l'indicateur de fin
}
```
