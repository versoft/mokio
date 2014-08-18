module Mokio
  module Concerns
    module Models
      #
      # Concern for Youtube model
      #
      module Youtube
        extend ActiveSupport::Concern

        included do
        end

        module ClassMethods
          #
          # Returns VideoInfo object with movie for specified movie_url.
          # Using <b>gem 'video_info'</b>
          #
          def find_movie(movie_url)
            begin
              video = VideoInfo.new(movie_url)
            rescue
              video = nil
              error = true
            end
            video
          end
        end
      end
    end
  end
end