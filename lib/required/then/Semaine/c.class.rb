# encoding: UTF-8

class Semaine

  DAYS = {
    'lundi'     => {small:'lun', indice: 1},
    'mardi'     => {small:'mar', indice: 2},
    'mercredi'  => {small:'mer', indice: 3},
    'jeudi'     => {small:'jeu', indice: 4},
    'vendredi'  => {small:'ven', indice: 5},
    'samedi'    => {small:'sam', indice: 6},
    'dimanche'  => {small:'dim', indice: 7}
  }

  # Le top de la première heure
  TOP_HOUR = 100



  class << self

    # Première heure de la journée
    # TODO: Pouvoir la définir par un fichier de configuration.
    def first_hour
      @first_hour ||= 7
    end


    # Méthode de classe qui ouvre la semaine courante si elle existe
    def open_current_if_exists
      now   = Time.now
      year  = now.year
      cweek = Date.today.cweek.to_i
      semaine = Semaine.new(year,cweek)
      semaine.open if semaine.exists?
    end

  end #/<< self
end #/Semaine
