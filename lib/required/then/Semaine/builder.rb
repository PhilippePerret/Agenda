class Semaine

  # Méthode de construction du fichier HTML de la semaine
  def build

    File.open(week_path,'wb'){|f| f.write full_code}
    puts "Semaine construite avec succès dans #{week_path}."
  end

  # Retourne le code complet du fichier
  def full_code
    build_body
    header + body + footer
  end

  def build_body
    gabarit = File.read(File.join(ASSETS_FOLDER,'gabarit.html'))
    gabarit.sub!(/__BLOCK_INFOS__/, block_infos)
    gabarit.sub!(/__COLONNE_HEURES__/, colonne_heures)
    Semaine::DAYS.each do |k, v|
      gabarit.sub!(/__#{k.upcase}__/, building_days[k])
    end
    @body = gabarit
  end

  def body
    return @body
  end

  # Tous les jours construits
  # C'est un hash avec en clé le nom fr du jour
  def building_days
    @building_days || begin
      h = {}
      Semaine::DAYS.each do |k, v|
        h.merge!(k => build_day(k))
      end
      h
    end
  end

  # Construction du jour +jour+
  def build_day jour
    djour = data[jour]
    return '' if djour.nil?
    str = ""
    data[jour].each do |heure, donnees|
      donnees.merge!({
        semaine: self,
        indice_jour: Semaine::DAYS[jour][:indice]
      })
      travail = Semaine::Jour::Travail.new(heure, donnees)
      str << travail.build
      add_trigger(travail.trigger_data)
    end
    str
  end


  # Construction de la colonne contenant les heures, depuis la première heure
  # définie jusqu'à la dernière.
  def colonne_heures
    @colonne_heures ||= begin
      str = ''
      16.times do |i|
        top = (i * 60) + Semaine::TOP_HOUR
        heure = Semaine.first_hour + i
        str << "<div class='heure' style='top:#{top}px;'><span class='heure'>#{(heure*60).to_hour}</span></div>"
        str << "<div class='demi-heure' style='top:#{top+30}px;'></div>"
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
    #{File.read(File.join(ASSETS_FOLDER,'gabarit.css')).gsub(/\n/,'')}
    /* Valeurs propres à la configuration */
    .semaine .jour {height: #{(24 - (Semaine::first_hour)) * 60}px;}
    </style>
    <script type="text/javascript">
      const WEEK_START_TIME = #{start_time_millieme};
      const WEEK_END_TIME = #{end_time_millieme};
      const FIRST_DAY_HOUR = #{Semaine.first_hour};
      const TRIGGERS = #{code_triggers};
      #{File.read(File.join(ASSETS_FOLDER,'gabarit.js'))}
    </script>
  </head>
  <body>
    HTML
  end

  def footer
    <<-HTML

    <div id="time_cursor">
      <span class="current_hour">11h32</span>
    </div>
  </body>
</html>

    HTML
  end
end
