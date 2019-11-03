# encoding: UTF-8
=begin
  Toutes les méthodes qui permettent de gérer les rubriques
=end

class Semaine

  # Les rubriques définies dans le fichier YAML de la semaine
  # C'est un Hash avec en clé l'identifiant de la rubrique (p.e. 'roman') et
  # en donnée l'instance {Semaine::Rubrique}
  def rubriques
    @rubriques ||= begin
      h = {}
      data['Rubriques'].each do |rub_id, rub_data|
        rub = Semaine::Rubrique.new(rub_id, rub_data)
        h.merge!(rub_id => rub)
      end if data['Rubriques']
      # puts "rubriques: #{h.inspect}"
      h
    end
  end

end #/Semaine
