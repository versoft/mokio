module Mokio
  module Concerns
    module Controllers
      #
      # Concern for LangsController
      #
      module Langs
        extend ActiveSupport::Concern
        included do
        end

        def set_breadcrumbs_prefix
          @breadcrumbs_prefix = "settings"
          @breadcrumbs_prefix_link = ""
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #

        def lang_params #:doc:
            params[:lang].permit(:name,:shortname,:active,:menu_id)
        end
      end
    end
  end
end
