# encoding: UTF-8

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
    @building_days ||= begin
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
    indice_jour = Semaine::DAYS[jour][:indice] - 1
    date_jour = from_jour + indice_jour
    str = ""
    # On ajoute la date exacte du jour
    str << "<div class='date_jour'>#{date_jour.strftime("%d %m %Y")}</div>"

    return str if djour.nil?

    # On commence par classer tous les travaux par temps pour pouvoir
    # récupérer facilement le temps du travail suivant quand la durée du
    # travail courant n'est pas défini
    # Il faut commencer par mettre l'heure dans les données
    travaux = data[jour].collect do |heure, donnees|
      donnees.merge!('heure' => heure)
    end.sort_by { |donnees| donnees['heure'].to_minutes }

    # puts "travaux : #{travaux.inspect}"

    travaux.each_with_index do |donnees, index|
      donnees.merge!({
        semaine: self,
        indice_jour: indice_jour
      })
      # Si la durée n'est pas définie dans le travail courant, il faut la
      # déduire du travail suivant
      if donnees['duree'].nil?
        next_travail = travaux[index + 1]
        donnees.merge!('duree' => if next_travail.nil?
            60
          else
            next_travail['heure'].to_minutes - donnees['heure'].to_minutes
          end)
      end
      travail = Semaine::Jour::Travail.new(donnees)
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
    code_css = File.read(File.join(ASSETS_FOLDER,'gabarit.css')).force_encoding('utf-8')
    code_css.gsub!(/\n/,'')
    code_js = File.read(File.join(ASSETS_FOLDER,'gabarit.js')).force_encoding('utf-8')
    <<-HTML
<!DOCTYPE html>
<html lang="fr" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Agenda du #{f_from_jour_short} au #{f_to_jour_short}</title>
    <style type="text/css">
    #{code_css}
    /* Valeurs propres à la configuration */
    .semaine .jour {height: #{(24 - (Semaine::first_hour)) * 60}px;}
    </style>
    <script type="text/javascript">
      const WEEK_START_TIME = #{start_time_millieme};
      const WEEK_END_TIME = #{end_time_millieme};
      const FIRST_DAY_HOUR = #{Semaine.first_hour};
      const TRIGGERS = #{code_triggers};
      #{code_js}
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
