class Semaine

  def data_file_exist?
    File.exists?(data_path)
  end
  def exist?
    File.exists?(week_path)
  end
  alias :exists? :exist?

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
