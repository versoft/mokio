module Mokio
  module FrontendHelpers
    #
    # Frontend helper methods used with Mokio::StaticModules objects
    #
    module StaticModulesHelper

      # returns all contents by position_name
      #
      # ==== Attributes
      #
      # * +position_name+ - name of the module position
      # * +always_displayed+ - display all modules for positions or only always displayed
      #
      # ==== Variables
      # * +content+ - single static module from result
      # * +position+ - module position active record result

      def build_static_modules(position_name,always_displayed = false)
        lang = Mokio::Lang.default
        position = Mokio::ModulePosition.find_by_name(position_name)
        html = " "

        if !position.nil?

          if always_displayed == true
            mod = Mokio::AvailableModule.static_module_active_for_lang(position.id,lang.id).only_always_displayed
          else
            mod = Mokio::AvailableModule.static_module_active_for_lang(position.id,lang.id)
          end
            html << build_content(mod,position)
        else
          html << "Position not found"
        end
        html.html_safe

      end

      #  builds html for a single position without tpl template
      #
      # ==== Attributes
      #
      # * +content+ - single static module from result
      #
      # ==== Variables
      # * +content.intro+ - static_module_intro from mokio_static_modules
      # * +content.content+ - static_module_content from mokio_static_modules

      def build_from_content(content)
        html = "<div class='static-module'>"
        html << "<div>#{content.intro}</div>"
        html << "<div>#{content.content}</div>"
        html << "</div>"
        html.html_safe
      end

      #  builds html for a single position with tpl template and render
      #
      # ==== Attributes
      #
      # * +content+ - single static module from result
      # * +tpl+ - tpl path
      #

      def build_from_view_file(content,tpl)
        @html = render :file => tpl.strip, :locals => { :content => content }
        @html.html_safe
      end

      #  check visibility and generate static modules tree from activerecord object
      #
      # ==== Attributes
      #
      # * +obj+ - static modules object from activerecord
      # * +position+ - module position object
      #

      def build_content(obj,position)

        if position.tpl.blank?
          html = "<div class='static-modules'>"
        else
          html = ""
        end

        obj.each do |pos|
        content = pos
          if(content.displayed?)
            if(position.tpl.blank?)
              html << build_from_content(content)
            else
              html << build_from_view_file(content,position.tpl)
            end
          end
        end

        if position.tpl.blank?
          html << "</div>"
        end
        html.html_safe
      end
    end
  end
end