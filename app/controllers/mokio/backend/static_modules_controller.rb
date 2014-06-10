module Mokio
  class Backend::StaticModulesController < Backend::CommonController

    private
      #
      # Never trust parameters from the scary internet, only allow the white list through.
      #
      def static_module_params
        params[:static_module].permit(:title, :content, :intro, :active, :always_displayed, :display_from, :display_to, :lang_id, { :module_position_ids => [] })
      end
  end
end