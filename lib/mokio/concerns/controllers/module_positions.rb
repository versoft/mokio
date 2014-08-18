module Mokio
  module Concerns
    module Controllers
      #
      # Concern for ModulePositions
      #
      module ModulePositions
        extend ActiveSupport::Concern

        included do
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #

          def module_position_params #:doc:
            params[:module_position].permit(:name,:tpl)
          end

      end
    end
  end
end