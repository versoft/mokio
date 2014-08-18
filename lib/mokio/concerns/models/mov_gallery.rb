module Mokio
  module Concerns
    module Models
      #
      # Concern for MovGallery model
      #
      module MovGallery
        extend ActiveSupport::Concern

        included do
        end

        def default_data_file
          Mokio::Youtube
        end
      end
    end
  end
end