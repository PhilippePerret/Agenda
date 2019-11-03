# encoding: UTF-8
=begin
  Toutes les méthodes qui permettent de traiter les textes
=end

class Semaine

  def remplace_variable_in str
    return str unless str.match(/\%\{/)

    str.gsub(/\%\{([A-Za-z_0-9]+)\}/){
      var = $1
      if data[var].nil?
        var
      else
        data[var]
      end
    }
  end

end #/Semaine
