class Semaine

  # Le top de la première heure
  TOP_HOUR = 40

  class << self

    # Première heure de la journée
    # TODO: Pouvoir la définir par un fichier de configuration.
    def first_hour
      @first_hour ||= 7
    end

  end #/<< self
end #/Semaine
