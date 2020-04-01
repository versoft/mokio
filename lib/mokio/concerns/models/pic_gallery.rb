module Mokio
  module Concerns
    module Models
      #
      # Concern for PicGallery model
      #
      module PicGallery
        extend ActiveSupport::Concern

        included do
        end

        #
        # Return constant
        #
        def default_data_file
          Mokio::Photo
        end

        module ClassMethods
          def has_gallery_enabled?
            true
          end
        end
      end
    end
  end
end