module Mokio
  module Concerns
    module Controllers
      #
      # Concern for StaticModulesController
      #
      module StaticModules
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
          def static_module_params #:doc:
            params[:static_module].permit(:title, :content, :intro, :active, :always_displayed, :display_from, :display_to, :lang_id, { :module_position_ids => [] })
          end
      end
    end
  end
end