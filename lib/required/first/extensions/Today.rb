# encoding: UTF-8
=begin
  Classe pour gérer le jour courant
=end

class Today
class << self

  def to_i
    @to_i ||= date.to_time.to_i
  end
  # Nom du jour de la semaine courante
  def mday
    @dweek ||= date.mday
  end

  # L'indice du jour de la semaine, dimanche == 0
  def week_index
    @week_index ||= date.wday
  end

  def year_index
    @year_index ||= date.yday
  end

  # Retourne le nom français du jour (p.e. "jeudi")
  def nom_jour
    @nom_jour ||= Semaine::DAYS_NAME[date.wday]
  end

  # Retourne true si on est dimanche
  def sunday?
    return date.sunday?
  end

  def date
    @data ||= Date.today
  end
end #/<< self
end #/Today
