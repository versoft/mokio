module Mokio
  module FrontendHelpers
    #
    # Frontend helper methods used with Mokio::Lang objects
    #
    module LangsHelper
      #
      # Builds forms with buttons to choose site language
      # Pass your controller action path and check params[:lang_code]
      #
      # ==== Attributes
      #
      # * +controller_action+ - your controller action path (e.g. "content_home_path")
      # * +image_folder+ - folder where helper will search country flag images (default: "langs" - searched in app/assets/images/langs)
      # * +submit_class+ - submit buttons css class (defaut: "btn-lang-submit")
      # * +image_ext+ - language flag image extension(defaut: "png")
      #
      def build_lang_menu(controller_action, image_folder = "langs", submit_class = "btn-lang-submit", image_ext = "png")
        html = ""
        Mokio::Lang.active.each do |lang|
          lang_form =  form_tag(controller_action, :id => "#{lang.shortname}_lang_form") do
            hidden_field_tag("lang_code", lang.shortname) +
            image_submit_tag("#{image_folder}/#{lang.shortname}.#{image_ext}", :class => submit_class)
          end
          html << lang_form
        end
        html.html_safe
      end
    end
  end
end