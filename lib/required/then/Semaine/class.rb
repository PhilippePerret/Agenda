class Semaine

  DAYS = {
    'lundi'     => {small:'lun'},
    'mardi'     => {small:'mar'},
    'mercredi'  => {small:'mer'},
    'jeudi'     => {small:'jeu'},
    'vendredi'  => {small:'ven'},
    'samedi'    => {small:'sam'},
    'dimanche'  => {small:'dim'}
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
