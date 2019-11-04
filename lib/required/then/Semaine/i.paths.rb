# encoding: UTF-8

class Semaine

  def exist?
    # Si le fichier HTML n'existe pas mais que le fichier data existe,
    # il faut (re)construire le fichier
    if data_file_exist? && !File.exists?(week_path)
      build
    end
    File.exists?(week_path)
  end
  alias :exists? :exist?

  # Retourne true si le fichier de données du fichier existe
  def data_file_exist?
    File.exists?(data_path)
  end

  def week_path
    @week_path ||= File.join(AGENDA_FOLDER,week_filename)
  end
  def week_filename
    @week_filename ||= "Semaine-#{affixe}.html"
  end
  def data_path
    @data_path ||= File.join(SEMAINE_FOLDER,"#{affixe}.yaml")
  end
  def affixe
    @affixe ||= "#{year}-#{week_number}"
  end

end #/Semaine
