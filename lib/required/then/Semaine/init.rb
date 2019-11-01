class Semaine

  attr_reader :year, :week_number

  def initialize annee, wnumber
    @year = annee
    @week_number = wnumber
  end

  def open
    `open "#{week_path}"`
  end

  def data
    @data ||= begin
      if exists?
        YAML.load_file(data_path)
      else
        {}
      end
    end
  end
end #/Semaine
