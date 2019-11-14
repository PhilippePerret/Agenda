#!/usr/bin/env ruby
# encoding: UTF-8

require_relative 'lib/_required'

if defined?(Semaine)

  Dir["#{SEMAINES_FOLDER}/*.yaml"].each do |fpath|

    year, cweek = File.basename(fpath,File.extname(fpath)).split('-')

    semaine = Semaine.new(year.to_i, cweek.to_i)

    # Si la semaine est à jour, rien à faire, sinon, on la reconstruit
    # Note : une semaine n'est pas à jour aussi si elle ne contient pas
    # le lien vers une autre semaine alors qu'elle existe (nouvelle semaine)
    if semaine.up_to_date? && !FORCE_REBUILD
      next
    else
      # Sinon, on reconstruit la semaine
      semaine.build
    end
  end

  # Ouvrir, la première fois :
  # semaine.open

else
  puts "La classe Semaine n'est pas défini"
end
