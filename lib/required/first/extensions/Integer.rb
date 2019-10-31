class Integer

  # Retourne le nombre de minutes en heure
  #   90 => 1h30
  def to_hour
    m = self
    hrs = m / 60
    mns = (m % 60).to_s.rjust(2,'0')
    return "#{hrs}h#{mns}"
  end

end
