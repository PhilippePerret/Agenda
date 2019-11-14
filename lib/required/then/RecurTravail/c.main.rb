# encoding: UTF-8
class RecurTravail
class << self

  # Méthode qui retourne la liste des travaux récurrents du jour +date+, pour les
  # ajouter à la liste de travaux +travaux+
  def works_of_day(date)
    tw = []
    all.each do |rwork|
      if rwork.on_day?(date)
        tw << rwork.data
      end
    end
    return tw
  end

  # Méthode principale qui crée toutes les instances de travaux récurrents
  # En retourne la liste Array
  #
  # Note : la liste est appelée quand on appelle RecurTravail::All
  def all
    @all ||= begin
      Dir["#{TRAVAUX_RECURRENTS_FOLDER}/*.yaml"].collect do |fpath|
        new(fpath)
      end
    end
  end
end #/<< self
end #/RecurTravail
