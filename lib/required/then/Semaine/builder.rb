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

    gabarit.sub!(/__COLONNE_HEURES__/, colonne_heures)
    gabarit.sub!(/__LUNDI__/, building_days['lundi'])
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
      travail = Semaine::Jour::Travail.new(heure, donnees)
      str << travail.build
    end
    str
  end


  # Construction de la colonne contenant les heures, depuis la première heure
  # définie jusqu'à la dernière.
  def colonne_heures
    @colonne_heures ||= begin
      str = ''
      10.times do |i|
        top = (i * 60) + Semaine::TOP_HOUR
        heure = Semaine.first_hour + i
        str << "<div class='heure' style='top:#{top}px;'><span class='heure'>#{(heure*60).to_hour}</span></div>"
      end
      str
    end
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
