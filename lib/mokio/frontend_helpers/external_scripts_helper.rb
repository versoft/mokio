module Mokio
  module FrontendHelpers
    #
    # Frontend helper methods used with Mokio::ExternalCodes objects
    #
    module ExternalScriptsHelper

      #  returns a single external code
      #
      # ==== Attributes
      #
      # * +code_name+ - external code name from mokio_external_codes

      def build_external_code(code_name)
        html = "";
        result  = Mokio::ExternalCode.find_by(name:code_name)
        if !result.blank?
          html = build_common(result)
        end
        html.html_safe
      end

      #  returns all external codes

      def build_all_external_codes
        html = "";
        result = Mokio::ExternalCode.all
        if !result.blank?
          result.each do |position|
            html = build_common(position)
          end
        end
        html.html_safe
      end

      # returns a single external code and generates html
      #
      # ==== Attributes
      #
      # * +obj+ - single external code object from ActiveRecord query result
      #
      # ==== Variables
      # * +obj.code+ - external code content from mokio_external_codes
      # * +obj.name - external code name from mokio_external_codes

      def build_common(obj)
        html = ""
        if !obj.blank?
          html << "<!--#{obj.name} - EXTERNAL CODE START-->\n"
          html << obj.code + "\n"
          html << "<!--#{obj.name} END -->\n"
          html.html_safe
        end
      end
    end
  end
end