#!/usr/bin/env ruby
# encoding: UTF-8

require_relative 'lib/_required'

if defined?(Semaine)

  [42, 43, 44, 45].each do |week_num|
    # On doit prendre le fichier voulu
    semaine = Semaine.new(2019, week_num)

    puts "Le fichier #{semaine.data_path} n'existe pas, la semaine sera vide." unless semaine.data_file_exist?

    semaine.build
  end

  # Ouvrir, la première fois :
  # semaine.open

else
  puts "La classe Semaine n'est pas défini"
end
