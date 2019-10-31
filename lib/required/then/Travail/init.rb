class Semaine
  class Jour
    class Travail

      attr_reader :data
      attr_reader :start_time, :end_time, :real_start_time, :real_end_time

      def initialize heure_str, donnees
        @data = donnees
        define_times(heure_str)
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
<div class="travail" style="top:#{top}px;height:#{height}px;background-color:#{couleur};">
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
          real_start_time - (6*60)
        end
      end

      # Hauteur en fonction de la durée, en pixels (sans unité)
      def height
        @height ||= begin
          duree
        end
      end

      def duree
        @duree ||= data['duree'].to_i
      end
      def action
        @action ||= data['faire']
      end
      def objet
        @objet ||= data['objet']
      end
      def f_objet
        @f_objet ||= objet ? " (#{objet})" : ""
      end
      def couleur
        @couleur ||= data['categorie'] || 'palegrey'
      end
    end #/Travail
  end #/Jour
end #/Semaine
