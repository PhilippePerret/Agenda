# encoding: UTF-8
=begin
  Méthodes d'instance pour créer la semaine
=end
class Semaine

  # - main -
  # Méthode principale qui procède à la création de la semaine (son fichier
  # YAML).
  # Pour ce faire, on utilise le dernier fichier données créés
  def create
    # On duplique le dernier fichier
    FileUtils.cp(Semaine.derniere.data_path, data_path)
    # On construit une première fois le fichier
    build
    # On l'ouvre dans le navigateur
    open
    # On ouvre le fichier de données pour pouvoir le définir
    `open "#{data_path}"`
    # On annonce qu'il faut modifier ce fichier pour l'actualiser
    # Notify.
  end


end #/Semaine
