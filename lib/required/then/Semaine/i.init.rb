# encoding: UTF-8

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

  def data_exists?
    return File.exists?(data_path)
  end
  alias :data_file_exist? :data_exists?

  # Retourne true si la semaine est à jour
  # Elle est à jour si :
  #   - son fichier de donnée existe
  #   - son fichier HTML existe
  #   - son fichier HTML est plus récent que son fichier de données
  #   - une semaine avant existe et cette semaine-ci contient le lien vers
  #     la semaine avant
  #   - une semaine après existe et cette semaine-ci contient le lien vers
  #     la semaine après
  def up_to_date?
    if !File.exists?(data_path)
      raise 'Pas de fichier data'
    end
    if !File.exists?(week_path)
      raise 'Pas de fichier HTML'
    end
    if File.stat(week_path).mtime < File.stat(data_path).mtime
      raise 'Le fichier de données est plus récent que le fichier HTML'
    end

    code = File.read(week_path).force_encoding('utf-8')

    code_has_prev_link = code.match(prev_week.week_filename)
    if prev_week.exists?
      unless code_has_prev_link
        raise 'Le fichier HTML ne contient pas de liens vers la semaine précédente (qui existe)'
      end
    else
      if code_has_prev_link
        raise 'Le fichier HTML contient un lien vers la semaine précédente (qui n’existe pas)'
      end
    end

    code_has_next_link = code.match(next_week.week_filename)
    if next_week.exists?
      unless code_has_next_link
        raise 'Le fichier HTML ne contient pas de liens vers la semaine suivante (qui existe)'
      end
    else
      if code_has_next_link
        raise 'Le fichier HTML contient un lien vers la semaine suivante (qui n’existe pas)'
      end
    end

  rescue Exception => e
    puts "Semaine #{year}-#{week_number} non up to date : #{e.message}"
    log("Semaine #{year}-#{week_number} pas à jour : #{e.message}")
    return false
  else
    return true
  end


end #/Semaine
