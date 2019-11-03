# encoding: UTF-8

=begin
  Méthodes propres pour les infos de la semaine
  (numéro, date de début et date de fin)
=end
class Semaine

  # Le bloc contenant les infos de la semaine, à ajouter en haut
  # à gauche
  def block_infos
    <<-HTML
    <div class="semaine-infos">
      <div class="semaine-number">
        <span class="arrow-other-week">#{prev_week_arrow}</span>
        <span>semaine </span><span>#{week_number}</span>
        <span class="arrow-other-week">#{next_week_arrow}</span>
      </div>
      <div class="semaine-open">
        <a href="atm:open?url=file://#{data_path}" title="Ouvrir le fichier de données de la semaine">ouvrir</a>
      </div>
      <div class="semaine-from">
        <div class="from-jour"><span class="label">du </span><span>#{f_from_jour}</span></div>
        <div class="to-jour"><span class="label">au </span><span>#{f_to_jour}</span></div>
      </div>
    </div>
    HTML
  end

  # Méthodes d'helper

  def f_from_jour
    @f_from_jour ||= from_jour.strftime("%d %m %Y")
  end
  def f_to_jour
    @f_to_jour ||= to_jour.strftime("%d %m %Y")
  end
  def f_from_jour_short
    @f_from_jour_short ||= from_jour.strftime("%d %m")
  end
  def f_to_jour_short
    @f_to_jour_short ||= to_jour.strftime("%d %m")
  end

  def prev_week_arrow
    @prev_week_arrow ||= begin
      if prev_week.exists?
        "<a href='#{prev_week.week_filename}'>◀︎</a>"
      else
        '<span class="discret">◀︎</span>'
      end
    end
  end

  def next_week_arrow
    @next_week_arrow ||= begin
      if next_week.exists?
        "<a href='#{next_week.week_filename}'>▶︎</a>"
      else
        '<span class="discret">▶︎</span>'
      end
    end
  end


  # Méthodes de calcul
  def from_jour
    @from_jour ||= Date.ordinal(year, week_first_day_number)
  end

  def to_jour
    @to_jour ||= Date.ordinal(year, 6 + week_first_day_number)
  end

  # Timestamp du départ de la semaine, en millième de secondes
  # (pour javascript)
  def start_time_millieme
    @start_time_millieme ||= from_jour.to_time.to_i * 1000
  end
  def end_time_millieme
    @end_time_millieme ||= begin
      first_jour_next_week = Date.ordinal(year, 7 + week_first_day_number)
      first_jour_next_week.to_time.to_i * 1000
    end
  end

  # Premier jour de la semaine, en nombre
  # Note : le premier jour de l'année a le nombre 0
  # ((nombre de la semaine - 1) * 7) + 1
  # Exemple : la 43e semaine commence du jour ((43 - 1) * 7) + 1
  # => 295
  def week_first_day_number
    @week_first_day ||= (week_number - 1) * 7
  end

  def prev_week
    @prev_week ||= begin
      n = week_number - 1
      a = year
      if n == 0
        n = 52
        a -= 1
      end
      Semaine.new(a, n)
    end
  end
  # Le path de la semaine suivante
  def next_week
    @next_week_path ||= begin
      n = week_number + 1
      a = year
      if n > 52
        n = 1
        a += 1
      end
      Semaine.new(a, n)
    end
  end

end #/Semaine
