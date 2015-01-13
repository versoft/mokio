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
      # * +image_folder+ - folder where helper will search country flag images (default: "langs" - searched in app/assets/images/langs)
      # * +nav_class+ - nav css class (defaut: "lang_nav")
      # * +image_ext+ - language flag image extension(defaut: "png")
      #
      def build_lang_menu(image_folder = "langs", nav_class = "lang_nav", image_ext = "png")
        lang_links = ''

        Mokio::Lang.active.each do |lang|
          lang_link =<<HTML
          <li>#{link_to_unless(I18n.locale.to_s == lang.shortname, image_tag("#{image_folder}/#{lang.shortname}.#{image_ext}"), root_url( locale: lang.shortname.to_sym ), class: 'lang-link')}</li>
HTML
          lang_links << lang_link
        end
        html =<<HTML
          <nav id="#{nav_class}">
            <ul id='lang_list'>
              #{lang_links}
            </ul>
          </nav>
HTML
        html.html_safe
      end

    end
  end
end