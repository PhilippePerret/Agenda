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

    # Retourne l'instance {Semaine} de la semaine courante
    def courante
      @courante ||= begin
        now   = Time.now
        year  = now.year
        cweek = Date.today.cweek.to_i
        Semaine.new(year,cweek)
      end
    end

    # Méthode qui lance la surveillance du dossier _Semaines pour
    # actualiser les semaines après modification des fichiers données
    def watch_data_folder
      `cd "#{APPFOLDER}";ls ./_Semaines/*.yaml | entr ./rebuild.rb /_`
    end

    # Retourne l'instance {Semaine} de la dernière semaine définie
    #
    # Permet de créer la nouvelle semaine en se basant sur le fichier
    # de la dernière semaine
    def derniere
      @derniere ||= begin
        ldf = Dir["#{SEMAINE_FOLDER}/*.yaml"].sort.last
        year,cweek = File.basename(ldf,File.extname(ldf)).split('-')
        Semaine.new(year, cweek)
      end
    end

  end #/<< self
end #/Semaine
