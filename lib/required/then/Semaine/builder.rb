class Semaine

  # Méthode de construction du fichier HTML de la semaine
  def build

    File.open(week_path,'wb'){|f| f.write full_code}
    puts "Semaine construite avec succès dans #{week_path}."
  end

  # Retourne le code complet du fichier
  def full_code
    header + body + footer
  end

  def body
    gabarit = File.read(File.join(ASSETS_FOLDER,'gabarit.html'))

    gabarit.sub(/__LUNDI__/, building_days['lundi'])
  end

  # Tous les jours construits
  # C'est un hash avec en clé le nom fr du jour
  def building_days
    @building_days || begin
      h = {}
      h['lundi'] = build_day('lundi')
      h
    end
  end

  # Construction du jour +jour+
  def build_day jour
    djour = data[jour]
    str = ""
    data[jour].each do |heure, donnees|
      str = "<div>#{heure} #{donnees['faire']}</div>"
    end
    str
  end


  def header
    <<-HTML
<!DOCTYPE html>
<html lang="fr" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Agenda semaine #{week_number}</title>
    <style type="text/css">
    #{File.read(File.join(ASSETS_FOLDER,'gabarit.css'))}
    </style>
  </head>
  <body>
    HTML
  end

  def footer
    <<-HTML

  </body>
</html>

    HTML
  end
end
