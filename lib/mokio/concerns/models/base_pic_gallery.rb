module Mokio
  module Concerns
    module Models
      #
      # Concern for PicGallery model
      #
      module BasePicGallery
        extend ActiveSupport::Concern

        included do
        end

        #
        # Return constant
        #
        def default_data_file
          Mokio::Photo
        end
      end
    end
  end
end