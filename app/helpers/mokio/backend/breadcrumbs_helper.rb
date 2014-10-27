module Mokio
  module Backend
    module BreadcrumbsHelper


      def breadcrumbs
        html  = "<li>#{breadcrumbs_arrow}</li>"
        t     = 'backend.breadcrumbs'
        route = "#{engine_root}"

        #prefix - optional - defined per controller

        unless (controller.breadcrumbs_prefix.blank?)
          html << '<li>'
          if (controller.breadcrumbs_prefix_link.blank?)
            html << "#{I18n.t("#{t}.#{controller.breadcrumbs_prefix}")}"
          else
            html << "<a href='#{route}#{controller.breadcrumbs_prefix_link}'>#{I18n.t("#{t}.#{controller.breadcrumbs_prefix}")}</a>"
          end
          html << '</li>'
          html << "<li>#{breadcrumbs_arrow}</li>"
        end

        #controller

        if (controller_name != 'contents' || (controller_name == 'contents' && obj.nil?)) && (!defined?(obj) || obj.blank?) #check if this is not the last breadcrumb
          html << "<li>#{I18n.t("#{t}.#{controller_name}")}</li>"
        else
          html << "<li><a href='#{route}#{controller_name}'>#{I18n.t("#{t}.#{controller_name}")}</a></li>"
        end


        #for contents controller we need to add link to actual content type controller

        if (controller_name == 'contents') && !obj.nil? #this only happens when we edit contents so can never be last breadcrumb
          html << "<li>#{breadcrumbs_arrow}</li>"
          index_link = obj.class.to_s.demodulize.tableize
          html << "<li><a href='#{route}#{index_link}'>#{I18n.t("#{t}.#{index_link}")}</a></li>"
        end

        #action



        if defined?(obj) && obj.present?
          html << "<li>#{breadcrumbs_arrow}</li>"
          html << breadcrumbs_obj_title(I18n.t("#{t}.#{controller.action_name}"))
        elsif ! controller.action_name == "index"
          html << "<li>#{breadcrumbs_arrow}</li>"
          html << I18n.t("#{t}.#{controller.action_name}")
        end

        html.html_safe

      end

      def breadcrumbs_arrow
        "<span class='divider'><span class='icon16 icomoon-icon-arrow-right-2'></span></span>"
      end

      def breadcrumbs_obj_title(translation)
        title   = obj.title if obj.has_attribute?( :title )
        title ||= obj.name if obj.has_attribute?( :name )
        title ||= obj.breadcrumb_name if obj.respond_to?(:breadcrumb_name)
        if title.blank?
          "<li>#{translation}</li>"
        else
          title = title.truncate(37)
          "<li>#{translation} - #{title}</li>"
        end
      end

    end
  end
end