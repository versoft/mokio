module Mokio
  module Concerns #:nodoc:
    module Controllers #:nodoc:
      #
      # Concern for BaseController
      #
      module Base
        extend ActiveSupport::Concern

        included do
          protect_from_forgery prepend: true
          layout "mokio/backend"

          before_action :authenticate_user!
          after_action :flash_to_headers    # json sending flash notices with ajax success see in main.js
          attr_accessor :breadcrumbs_prefix
          attr_accessor :breadcrumbs_prefix_link
          before_action :set_breadcrumbs_prefix
          before_action :prepare_locale
        end

        #
        # Sending flash messages in X-Flash-Messages header.
        # Decoding to UTF-8 with ajax success placed in main.js.
        # <b>after_action</b> in BaseController
        #
        def flash_to_headers
          if request.xhr?
            flash_messages = {}

            flash_messages[:notice] = CGI::escape(flash[:notice].to_str) if flash[:notice]
            flash_messages[:error]  = CGI::escape(flash[:error].to_str) if flash[:error]
            flash_messages[:info]   = CGI::escape(flash[:info].to_str) if flash[:info]

            response.headers['X-Flash-Messages'] = flash_messages.to_json
            flash.discard
          end
        end

        #
        # Redirects back if back if available otherwise redirects to specified url, flash message is displayed
        #
        def redirect_back(format, url, message)
          format.html { redirect_to url, notice: message }
          format.json { head :no_content }
        end

        def set_breadcrumbs_prefix
          @breadcrumbs_prefix = ""
          @breadcrumbs_prefix_link = ""
        end

        def prepare_locale
          I18n.locale = session[:locale_cms] || Mokio.cms_locale
          session[:locale_cms] = I18n.locale
        end

        #
        # override current_ability to use Mokio's one
        #
        def current_ability
          @current_ability ||= Mokio::Ability.new(current_user)
        end
      end
    end
  end
end