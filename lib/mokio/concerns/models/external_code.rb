module Mokio
  module Concerns
    module Models
      
      module ExternalCode
        extend ActiveSupport::Concern
           
        included do

          include Mokio::Concerns::Models::Common

          validates :name, presence: true
          validates :code, presence: true
        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            ["name", "code"]
          end
        end

        def code_view
          self.code.truncate(200)
        end           
      end
    end
  end
end      
