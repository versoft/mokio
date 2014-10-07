module Mokio
  module FrontendHelpers
    # Frontend helper methods used with Mokio::ExternalScripts objects
    #
    module ExternalScriptsHelper

      #
      #  returns a single external script
      #

      # ==== Attributes
      #
      # * +script_name+ - external script name from mokio_external_scripts

      def build_external_script(script_name)
        html = "";
        result  = Mokio::ExternalScript.find_by(name:script_name)
        if !result.blank?
          html = build_common(result)
        end
        html.html_safe
      end

      #
      #  returns all external scripts
      #

      # ==== Variables
      # * +result+ - all external scripts from mokio_external_scripts

      def build_all_external_scripts
        html = "";
        result = Mokio::ExternalScript.all
        if !result.blank?
          result.each do |position|
            html = build_common(position)
          end
        end
        html.html_safe
      end

      #
      # build a single external script html
      #
      # ==== Attributes
      #
      # * +obj+ - single external script object from ActiveRecord query result
      #
      # ==== Variables
      # * +obj.script+ - external script content from mokio_external_scripts
      # * +obj.name+ - external script name from mokio_external_scripts

      def build_common(obj)
        html = ""
        if !obj.blank?
          html << "<!--#{obj.name} - EXTERNAL SCRIPT START-->\n"
          html << obj.script + "\n"
          html << "<!--#{obj.name} END -->\n"
          html.html_safe
        end
      end
    end
  end
end