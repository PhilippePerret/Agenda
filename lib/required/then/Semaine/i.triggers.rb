# encoding: UTF-8

=begin
  Méthodes de la semaine (du constructeur) qui permettent de définir
  les déclencheurs d'alerte des travaux
=end
class Semaine

  # Méthode générale qui retourne le code JS des triggers
  def code_triggers
    # pour faire des essais
    # h = {}
    # # Un temps avant
    # n = (Time.now.to_i + 10) * 1000
    # h.merge!(n => {message: "L'action à accomplir dix secondes après ouverture"})
    # # Un temps plus loin
    # n = (Time.now.to_i + 3600) * 1000
    # h.merge!(n => {message: "Le travail dans une heure"})
    # return h.to_json
    return triggers.to_json
  end

  def triggers; @triggers || {} end

  def add_trigger data
    @triggers ||= {}
    @triggers.merge!(data[:time] => data)
  end

end #/Semaine
