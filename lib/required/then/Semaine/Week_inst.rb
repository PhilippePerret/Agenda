class Semaine

  attr_reader :year, :week_number

  def initialize annee, wnumber
    @year = annee
    @week_number = wnumber
  end

  def data_file_exist?
    File.exists?(data_path)
  end
  def exist?
    File.exists?(week_path)
  end

  def week_path
    @week_path ||= File.join(SEMAINE_FOLDER,'agenda',"#{affixe}.html")
  end
  def data_path
    @data_path ||= File.join(SEMAINE_FOLDER,"#{affixe}.yaml")
  end
  def affixe
    @affixe ||= "#{year}-#{week_number}"
  end

end #/Semaine
