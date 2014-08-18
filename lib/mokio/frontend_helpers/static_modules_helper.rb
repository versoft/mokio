module Mokio
  module FrontendHelpers
    #
    # Frontend helper methods used with Mokio::StaticModules objects
    #
    module StaticModulesHelper

      # returns all contents by section_name
      #
      # ==== Attributes
      #
      # * +section_name+ - name of the module position
      #
      # ==== Variables
      # * +content+ - single static module from result

      def build_static_modules(section_name)

        section = Mokio::ModulePosition.find_by(name:section_name)
        html = "<div class='static-modules'>"
        av_mod = Mokio::AvailableModule.where(module_position_id:section.id).all()

        av_mod.each do |pos|
          content = pos.static_module
          if(content.displayed?)
            if(!content.tpl.nil?)
              html << build_content(content)
            else
              html << build_from_view_file(content)
            end
          end
        end
        html << "</div>"
        html.html_safe
      end

      #  builds html for a single position
      #
      # ==== Attributes
      #
      # * +content+ - single static module from result
      #
      # ==== Variables
      # * +content.intro+ - static_module_intro from mokio_static_modules
      # * +content.content+ - static_module_content from mokio_static_modules

      def build_content(content)
        html = "<div class='static-module'>"
        html << "<div>#{content.intro}</div>"
        html << "<div>#{content.content}</div>"
        html << "</div>"
        html.html_safe
      end

      #  builds html for a single position from view
      #
      # ==== Attributes
      #
      # * +content+ - single static module from result
      #

      def build_from_view_file(content)
        view = ActionView::Base.new(ActionController::Base.view_paths, {})
        view.render(:file => "#{content.tpl}", :locals => content, :layout => false)
      end

    end
  end
end