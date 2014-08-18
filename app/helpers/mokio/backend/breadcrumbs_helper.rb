module Mokio
  module Backend
    module BreadcrumbsHelper
      # def breadcrumbs
      #   breadcrumbs = request.original_url.gsub(/\S+\/\/[^\/]+\/[^\/]+/, '').split('/').reject! {|b| b.empty? || b.match(/^(\d)+$/) }
      #   return unless breadcrumbs

      #   last = breadcrumbs.last

      #   capture_haml do
      #     haml_tag :li do
      #       breadcrumbs_arrow
      #     end

      #     t = "backend.breadcrumbs"
      #     route = "#{engine_root}"

      #     breadcrumbs.each_with_index do |b, i|
      #       content = false
      #       route  += "#{b}"

      #       haml_tag :li do
      #         if b.match(/edit/)
      #           if breadcrumbs[i-1].match(/contents/)
      #             breadcrumbs_obj_title I18n.t("#{t}.#{obj.type.to_s.tableize.gsub("mokio/", "")}_edit")
      #           else
      #             if defined?(obj)
      #               breadcrumbs_obj_title I18n.t("#{t}.#{breadcrumbs[i-1]}_edit")
      #             else
      #               haml_concat I18n.t("#{t}.#{breadcrumbs[i-1]}_edit")
      #             end
      #           end
      #         elsif b.match(/new/)
      #           haml_tag :a, :href => "#{engine_root}#{breadcrumbs[i-1]}/new" do
      #             haml_concat I18n.t("#{t}.#{breadcrumbs[i-1]}_new")
      #           end
      #         else
      #           Mokio::Content.subclasses.each do |s|
      #             if s.to_s.tableize == "mokio/#{b}"
      #               haml_concat I18n.t("#{t}.add_content")
      #               content = true
      #             end
      #           end

      #           unless content
      #             unless b.match(/\?\D+\=/)
      #               haml_tag :a, :href => route do
      #                 haml_concat I18n.t("#{t}.#{b}")
      #               end
      #             else
      #               haml_concat b.gsub(/\S+\=/, '')
      #             end
      #           end
      #         end

      #         breadcrumbs_arrow unless b == last
      #       end
      #     end
      #   end
      # end

      def breadcrumbs
        breadcrumbs = request.original_url.gsub(/\S+\/\/[^\/]+\/[^\/]+/, '').split('/').reject! {|b| b.empty? || b.match(/^(\d)+$/) }
        return unless breadcrumbs

        last  = breadcrumbs.last
        html  = "<li>#{breadcrumbs_arrow}</li>"
        t     = "backend.breadcrumbs"
        route = "#{engine_root}"

        breadcrumbs.each_with_index do |b, i|
          content = false
          route  += "#{b}"

          html << "<li>"

          if b.match(/edit/)
            if breadcrumbs[i-1].match(/contents/)
              html << breadcrumbs_obj_title(I18n.t("#{t}.#{obj.type.to_s.tableize.gsub("mokio/", "")}_edit"))
            else
              if defined?(obj)
                html << breadcrumbs_obj_title(I18n.t("#{t}.#{breadcrumbs[i-1]}_edit"))
              else
                html << I18n.t("#{t}.#{breadcrumbs[i-1]}_edit")
              end
            end
          elsif b.match(/new/)
            html << "<a href='#{engine_root}#{breadcrumbs[i-1]}/new'>#{I18n.t("#{t}.#{breadcrumbs[i-1]}_new")}</a>"
          else
            Mokio::Content.subclasses.each do |s|
              if s.to_s.tableize == "mokio/#{b}"
                html << I18n.t("#{t}.add_content")
                content = true
              end
            end

            unless content
              unless b.match(/\?\D+\=/)
                html << "<a href='#{route}'>#{I18n.t("#{t}.#{b}")}</a>"
              else
                html << b.gsub(/\S+\=/, '')
              end
            end            
          end

          html << breadcrumbs_arrow unless b == last
          html << "</li>"
        end

        html.html_safe
      end

      # def breadcrumbs_arrow
      #   haml_tag :span, :class => "divider" do
      #     haml_tag :span, :class => "icon16 icomoon-icon-arrow-right-2"
      #   end     
      # end

      def breadcrumbs_arrow
        "<span class='divider'><span class='icon16 icomoon-icon-arrow-right-2'></span></span>"
      end

      # def breadcrumbs_obj_title(translation)
      #   haml_tag :li do
      #     haml_concat translation
      #   end

      #   haml_tag :li do
      #     title = obj.title if obj.has_attribute?( :title )
      #     title ||= obj.name if obj.has_attribute?( :name )
      #     title ||= obj.breadcrumb_name

      #     haml_concat "- #{title}"
      #   end
      # end

      def breadcrumbs_obj_title(translation)
        title   = obj.title if obj.has_attribute?( :title )
        title ||= obj.name if obj.has_attribute?( :name )
        title ||= obj.breadcrumb_name

        "<li>#{translation}</li><li> - #{title}</li>"
      end

    end
  end
end