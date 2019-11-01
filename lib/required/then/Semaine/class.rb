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

  end #/<< self
end #/Semaine
