> -   Quelles informations sur l\'image avant et l\'image après sont
>     exactes?
>
>     > ::: {.eqt}
>     > iavantapres
>     >
>     > A)  `I`{.interpreted-text role="eqt"} L\'image après ne contient
>     >     que des nuplets validés par un *commit*
>     > B)  `C`{.interpreted-text role="eqt"} L\'image avant ne contient
>     >     que des nuplets validés par un *commit*
>     > C)  `I`{.interpreted-text role="eqt"} Toutes les lectures se
>     >     font dans l\'image avant
>     > D)  `I`{.interpreted-text role="eqt"} Toutes les lectures se
>     >     font dans l\'image après
>     > :::
>
> -   Dans quel mode a-t-on besoin de conserver plus d\'une version dans
>     l\'image avant?
>
> > ::: {.eqt}
> > iavantapres2
> >
> > A)  `C`{.interpreted-text role="eqt"} En `repeatable read`
> > B)  `I`{.interpreted-text role="eqt"} En `read committed`
> > C)  `I`{.interpreted-text role="eqt"} En `serializable`
> > :::
>
> -   Jusqu\'à quand doit-on garder une version $e_i$ estampillée à
>     l\'instant $i$
>
> > ::: {.eqt}
> > estampilee
> >
> > A)  `I`{.interpreted-text role="eqt"} Pour toujours
> > B)  `I`{.interpreted-text role="eqt"} Tant que la transaction qui a
> >     écrit $e_i$ est active
> > C)  `C`{.interpreted-text role="eqt"} Tant qu\'il existe une
> >     transaction qui a débuté avant $i$
> > D)  `I`{.interpreted-text role="eqt"} Tant qu\'il existe une
> >     transaction qui a déjà lu $e_i$
> > :::
