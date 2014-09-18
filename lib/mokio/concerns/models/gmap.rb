module Mokio
  module Concerns
    module Models
      #
      # Concern for Gmap model
      #
      module Gmap
        extend ActiveSupport::Concern

        included do
          has_one :content
          accepts_nested_attributes_for :content, allow_destroy: true
          validates :full_address, :lat, :lng, presence: true
        end

        module ClassMethods
          #
          # Table of gmap attributes
          #
          def gmap_attributes
            [ 
              :id, :full_address, :street_number, :route, :locality, :postal_code, :country, 
              :administrative_area_level_2, :administrative_area_level_1, :gtype, :lat, :lng, :zoom
            ]
          end
        end
      end
    end
  end
end