# Agenda

* [Présentation générale](#presentation)
* [Créer une semaine](#create_week)
  * [Utiliser des variables](#use_variables)

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
