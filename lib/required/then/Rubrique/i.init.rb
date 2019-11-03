# encoding: UTF-8
class Semaine
class Rubrique

  attr_reader :id, :data

  def initialize id, data
    @id = id
    @data = data
  end

  def titre
    @titre ||= data['titre']
  end
  def couleur
    @couleur ||= data['couleur'] || 'whitesmoke'
  end
  # La catégorie, si elle est définie, mais attention, elle peut l'être
  # aussi pour chaque tâche entendu qu'une rubrique peut appartenir à
  
  def categorie
    @categorie ||= data['categorie']
  end

end #/Rubrique
end#/Semaine
