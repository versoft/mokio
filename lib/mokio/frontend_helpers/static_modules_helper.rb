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
      #
      # ==== Variables
      # * +content+ - single static module from result
      # * +position+ - module position active record result

      def build_static_modules(position_name)
        lang = Mokio::Lang.default
        position = Mokio::ModulePosition.find_by(name:position_name)
        mod = Mokio::AvailableModule.static_module_with_always_displayed_and_active_for_lang(position.id,lang.id)
        html = " "
        html << build_content(mod,position) #mod = obiekt static module
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

      #  returns all always displayed static modules
      #

      def build_always_displayed()
        lang = Mokio::Lang.default
        allways_displayed = Mokio::StaticModule.where(:always_displayed => true,:lang_id => lang.id,:active=>true)
        build_content(allways_displayed,Mokio::ModulePosition.new)
      end
    end
  end
end