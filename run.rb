#!/usr/bin/env ruby
# encoding: UTF-8

require_relative 'lib/_required'

if defined?(Semaine)

  # On doit prendre le fichier voulu
  semaine = Semaine.new(2019,43)

  puts "Désolé, le fichier #{semaine.data_path} n'existe pas." unless semaine.data_file_exist?

else
  puts "La classe Semaine n'est pas défini"
end
