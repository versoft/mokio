module Mokio
  module Concerns
    module Controllers
      #
      # Concern for ExternalController
      #
      module ExternalCodes
        extend ActiveSupport::Concern

        included do
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #

          def external_code_params #:doc:
            params[:external_code].permit(:name,:code)
          end

     
      end
    end
  end
end