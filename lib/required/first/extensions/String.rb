# encoding: UTF-8


class String

  # Reçoit l'heure sous la forme "3h30" ou "h:MM" et retourne le nombre
  # de minutes (integer)
  def to_minutes
    hrs, mns = self.split(/[h\:]/)
    return hrs.to_i * 60 + mns.to_i
  end
  
end
