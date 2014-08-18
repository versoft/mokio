module Mokio
  module Concerns
    module Models
      #
      # Concern for ModulePosition model
      #
      module ModulePosition  extend ActiveSupport::Concern

        include Mokio::Concerns::Models::Common
        included do
          has_and_belongs_to_many :static_modules, :join_table => "mokio_available_modules"
          accepts_nested_attributes_for :static_modules

          amoeba do
            include_field :static_modules
          end
        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            ["name"]
          end
        end

        def editable
          true
        end

        def deletable
          true
        end

      end
    end
  end
end