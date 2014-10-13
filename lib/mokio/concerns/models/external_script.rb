module Mokio
  module Concerns
    module Models

      module ExternalScript
        extend ActiveSupport::Concern

        included do

          include Mokio::Concerns::Models::Common

          validates :name, presence: true
          validates :script, presence: true
        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            ["name", "script"]
          end
        end

        def code_view
          self.script.truncate(200)
        end

        def editable  #:nodoc:
          true
        end

        def deletable  #:nodoc:
          true
        end


      end
    end
  end
end