module Mokio
  module Backend
    module BreadcrumbsHelper

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
          elsif b == "new"
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

      def breadcrumbs_arrow
        "<span class='divider'><span class='icon16 icomoon-icon-arrow-right-2'></span></span>"
      end

      def breadcrumbs_obj_title(translation)
        title   = obj.title if obj.has_attribute?( :title )
        title ||= obj.name if obj.has_attribute?( :name )
        title ||= obj.breadcrumb_name

        "<li>#{translation}</li><li> - #{title}</li>"
      end

    end
  end
end