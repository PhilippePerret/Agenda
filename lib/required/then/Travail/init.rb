# encoding: UTF-8

class Semaine
  class Jour
    class Travail

      attr_reader :data
      attr_reader :start_time, :end_time, :real_start_time, :real_end_time

      def initialize donnees
        @data = donnees
        define_times(donnees['heure'])
      end

      # Les données à retourner pour le trigger javascript
      def trigger_data
        @trigger_data ||= {
          time:    abs_start_time,
          message: action,
          categorie: categorie
        }
      end
      def define_times hstr
        @start_time = hstr
        @start_hour, @start_minute = hstr.split('h')
        @start_hour       = @start_hour.to_i * 60
        @start_minute     = @start_minute.to_i
        @real_start_time  = @start_hour + @start_minute
        @real_end_time    = @real_start_time + duree
        @end_time         = @real_end_time.to_hour
      end

      # Retourne le code HTML pour le créneau horaire
      def build
        <<-HTML
<div
  class="travail"
  style="top:#{top}px;height:#{height}px;background-color:#{couleur};"
  title="#{note}">
  <div class="faire">
    #{action}#{f_objet}
  </div>
  <div class="time">#{start_time} - #{end_time}</div>
</div>
        HTML
      end


      # Hauteur du div en fonction du temps, en pixels (sans unité)
      def top
        @top ||= begin
          rel_start_time + Semaine::TOP_HOUR
        end
      end

      # Temps relatif par rapport au début de la journée
      # Par exemple, si le début de la journée est défini à 7:00,
      # 8:00 aura 60 (1 heure) comme temps de départ relatif
      def rel_start_time
        @rel_start_time ||= real_start_time - Semaine::first_hour * 60
      end

      # Le timestamp absolu du travail, en fonction du jour
      def abs_start_time
        @abs_start_time ||= begin
          semaine.start_time_millieme + (indice_jour * 3600 * 24 * 1000) + (real_start_time * 60 * 1000)
        end
      end

      # Hauteur en fonction de la durée, en pixels (sans unité)
      def height
        @height ||= begin
          duree - 8 # 8 pour le padding vertical
        end
      end

      def duree
        @duree ||= data['duree'].to_i
      end
      def action
        @action ||= semaine.remplace_variable_in(data['faire'])
      end
      def categorie
        @categorie ||= data['categorie']
      end
      def semaine
        @semaine ||= data[:semaine]
      end
      def indice_jour
        @indice_jour ||= data[:indice_jour] - 1
      end
      def objet
        @objet ||= data['objet']
      end
      def f_objet
        @f_objet ||= objet ? " (#{objet})" : ""
      end
      def couleur
        @couleur ||= (rubrique && rubrique.couleur) || 'whitesmoke'
      end
      def rubrique
        @rubrique ||= begin
          if data['rubrique']
            semaine.rubriques[data['rubrique']]
          end
        end
      end
      def categorie
        @categorie ||= data['categorie'] || (rubrique && rubrique.categorie)
      end
      def note
        @note ||= data['note']
      end
    end #/Travail
  end #/Jour
end #/Semaine
