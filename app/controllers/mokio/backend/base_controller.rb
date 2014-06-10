# -*- encoding : utf-8 -*-
module Mokio
  class Backend::BaseController < Mokio::ApplicationController
    protect_from_forgery
    layout "mokio/backend"

    before_action :authenticate_user!

    after_filter :flash_to_headers # json sending flash notices with ajax success see in main.js

    def flash_to_headers
      if request.xhr?
        #
        # decoding to UTF-8 with ajax success placed in main.js
        #
        flash_messages = {}

        flash_messages[:notice] = CGI::escape(flash[:notice].to_str) if flash[:notice]
        flash_messages[:error]  = CGI::escape(flash[:error].to_str) if flash[:error]
        flash_messages[:info]   = CGI::escape(flash[:info].to_str) if flash[:info]

        response.headers['X-Flash-Messages'] = flash_messages.to_json
        flash.discard
      end
    end

    #
    # redirects back if back if available otherwise redirects to specified url, flash message is displayed
    #
    def redirect_back(format, url, message)
      begin
        format.html { redirect_to :back, notice: message }
        format.json { head :no_content }
      rescue ::ActionController::RedirectBackError
        format.html { redirect_to url,   notice: message }
        format.json { head :no_content }
      end
    end
  end
end