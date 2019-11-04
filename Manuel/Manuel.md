# Agenda

* [Présentation générale](#presentation)
* [Créer une semaine](#create_week)
  * [Utiliser des variables](#use_variables)
* [Travaux récurrents](#travaux_recurrents)

<a name="presentation"></a>

## Présentation générale

**Agenda** permet de gérer l'emploi du temps de ses semaines et d'avertir à chaque changement de travail.


<a name="create_week"></a>

## Créer une semaine

Une semaine se crée en créant un fichier `YAML` dans le dossier `./_Semaines`.

> On peut le créer simplement en utilisant la commande [TODO]

C'est un fichier qui définit simplement l'emploi du temps en le structurant de cette manière :

~~~yaml

lundi:
  8h00:
    faire: Action à entreprendre à 8 heures, d'une durée de 30 minutes.
    duree: 30
  9h00:
    faire: Action à entreprendre à 9 heures qui ira jusqu'à la prochaine tâche.
  11h00:
    faire: Action à 11h00 de la rubrique "Roman"
    rubrique: Roman
    note: "Une note à afficher quand on passe la souris sur le jour."

  # Etc. jusqu'à la fin de la journée

mardi:
  8h00:
    faire: Action à faire à 8 heures le mardi, d'une durée d'une heure trente.
    duree: 90

  # Etc. jusqu'à la fin de la journée

# Etc. jusqu'à la fin de la semaine
~~~

Comme on le voit ci-dessus, on peut utiliser des rubriques. Ces rubriques doivent être définies de préférence en haut du fichier, de cette façon :

~~~yaml

rubriques:
  Roman:
    titre:    Roman
    couleur:  whitesmoke # la couleur (nom ou hexadécimal)

~~~


<a name="use_variables"></a>

### Utiliser des variables

Définition de la variable (en haut du fichier YAML) :

~~~YAML

ma_variable: La valeur de ma variable

~~~

Utilisation de la variable dans la définition de la semaine :

~~~yaml

  lundi:
    10h00:
      faire: Il faut dire que ma variable vaut %{ma_variable}.

~~~

Donc le signe pourcentage (`%`) et des crochets entourants le nom exact de la variable.

Par exemple, si on travaille toute la semaine sur un roman et qu'on ne veut pas répéter son nom ou, mieux, qu'on veut pouvoir utiliser le même "gabarit" de semaine en changeant très facilement le titre du roman, le fichier pourra contenir :

~~~yaml

  roman: "Mon plus beau roman"

  lundi:
    6h00:
      faire: Travail sur la structure de %{roman}

  # ...
  mardi:
    6h00:
      faire: Travail sur les personnages de %{roman}.

  # ...

  mercredi:
    6h00:
      faire: Rédaction du premier jet de « %{roman} ».
      # ...

  jeudi:
    6h00:
      faire: Rédaction du premier jet de « %{roman} ».

  # ...

~~~

> Quand on dupliquera cette semaine pour programmer la semaine suivante, il

<a name="travaux_recurrents"></a>

## Travaux récurrents

Les travaux récurrents permettent de faciliter encore la définition des semaines, en ne définissant le travail qu'une seule fois. Par exemple, si un travail doit être fait quotidiennement (sauf le dimanche), il est plus simple de définir un travail récurrent que d'écrire le travail six fois dans le fichier de données de la semaine.

Un travail récurrent se crée dans le dossier `./_Semaines/_travaux-recurrents`.

C'est un fichier YAML qui définit ces données :

~~~yaml

--
  faire: "Le titre du travail, ce qu'il y a à faire"
  frequence: 1    # la fréquence, en nombre de jours (cf. ci-dessous)
  frequence_start: "22/07/2019" # date de départ de la fréquence
  jours: [...]    # Si la fréquence n'est pas utilisée, liste des jours
                  # Par exemple ['mardi', 'jeudi']
  heure: 10h20    # heure d'exécution du travail
  duree: 90       # la durée du travail, en nombre de minutes
  rubrique: "x"   # en fonction des définitions
  categorie: "x"  # en fonction des définitions
  note: "Une note à afficher quand on passe la souris sur le jour."
~~~

### Fréquence

Un travail qui n'a pas de fréquence définie ou qui a une fréquence de 1 est un travail quotidien (tous les jours sauf le dimanche ou le jour défini comme dimanche).

Quand on définit la fréquence, elle est considérée soit depuis le début de l'année, soit depuis la date `frequence_start` (définie par `JJ/MM/AAAA`).

### Durée

La durée est définie par la propriété `duree`, en nombre de minutes. Si elle n'est pas définie, la fin sera calculée en fonction du travail suivant dans la journée. Ainsi il est possible d'avoir un travail quotidien de durée différente en fonction des jours.
