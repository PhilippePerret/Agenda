# encoding: UTF-8
class RecurTravail

  attr_reader :path

  def initialize fpath
    @path = fpath
  end

  # Retourne true si le travail doit se faire le jour {Date} +jour+
  def on_day? jour
    return false  if jour.to_date.sunday?
    return true   if quotidien?
    return jours.contains?(Semaine::DAYS_NAME[jour.wday]) if jours
    return sur_frequence?(jour)
  end

  # Retourne true si c'est un travail récurrent quotidien
  # Un travail récurrent quotidien ne possède pas de fréquence ou possède
  # une fréquence de 1
  def quotidien?
    frequence.nil? || frequence === 1
  end

  # Retourne true si la fréquence est définie, différente de 1, et qu'elle tombe
  # sur le jour courant
  # Pour le calcul, soit la date de départ est définie (start_date), soit on
  # prend le début d'année.
  def sur_frequence?(jour)
    d_index =
      if frequence_start
        jrs, mon, ann = frequence_start.split(/[\-\/]/)
        sdate = Date.new(ann.to_i, mon.to_i, jrs.to_i)
        ((jour.to_time.to_i - sdate.to_time.to_i)/(3600*24)).abs
      else
        jour.yday
      end
    d_index.to_i / frequence == d_index.to_f / frequence
  end

  def data
    @data ||= YAML.load_file(path)
  end
  def faire
    @faire ||= data['faire']
  end
  def heure
    @heure ||= data['heure']
  end
  def duree
    @duree ||= data['duree']
  end
  def frequence
    @frequence ||= data['frequence']
  end
  def frequence_start
    @frequence_start ||= data['frequence_start']
  end
  def jours
    @jours ||= data['jours']
  end
  def rubrique
    @rubrique ||= data['rubrique']
  end
  def categorie
    @categorie ||= data['categorie']
  end
end#/RecurTravail
