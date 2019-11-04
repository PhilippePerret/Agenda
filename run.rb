#!/usr/bin/env ruby
# encoding: UTF-8

=begin

  Script pour lancer la journée de travail
  (il doit être lancé au démarrage)

  - il affiche dans le navigateur par défaut le fichier html de la semaine,
    le construit le cas échéant
    Si la semaine n'existe pas, le script s'arrête là.
  - il lance la surveillance des fichiers de données semaines pour les
    reconstruire au besoin.

=end
require_relative 'lib/_required'

# On ouvre le fichier de la semaine courante dans le navigateur
if Semaine.courante.exists?
  Semaine.courante.open
else
  # Si la semaine courante n'existe pas, on la crée et on lance le script qui
  # surveille les modifications
  Semaine.courante.create
  Semaine.watch_data_folder
end
