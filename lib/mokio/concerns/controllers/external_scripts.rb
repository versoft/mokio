module Mokio
  module Concerns
    module Controllers
      #
      # Concern for ExternalScriptsController
      #
      module ExternalScripts
        extend ActiveSupport::Concern

        included do
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #

          def external_script_params #:doc:
            params[:external_script].permit(:code,:script)
          end
      end
    end
  end
end