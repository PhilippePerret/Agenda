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
      <div class="semaine-number"><span>semaine </span><span>#{week_number}</span></div>
      <div id="" class="semaine-from">
        <div class="from-jour"><span class="label">du </span><span>#{f_from_jour}</span></div>
        <div class="to-jour"><span class="label">au </span><span>#{f_to_jour}</span></div>
      </div>
    </div>
    HTML
  end

  def f_from_jour
    @f_from_jour ||= from_jour.strftime("%d %m %Y")
  end
  def f_to_jour
    @f_to_jour ||= to_jour.strftime("%d %m %Y")
  end

  def from_jour
    @from_jour ||= Date.ordinal(year, week_first_day_number)
  end

  def to_jour
    @to_jour ||= Date.ordinal(year, 6 + week_first_day_number)
  end

  # Premier jour de la semaine, en nombre
  # Note : le premier jour de l'année a le nombre 0
  # ((nombre de la semaine - 1) * 7) + 1
  # Exemple : la 43e semaine commence du jour ((43 - 1) * 7) + 1
  # => 295
  def week_first_day_number
    @week_first_day ||= (week_number - 1) * 7
  end

end #/Semaine
