module Mokio
  module Backend
    module BreadcrumbsHelper
      def breadcrumbs
        breadcrumbs = request.original_url.gsub(/\S+\/\/[^\/]+\/[^\/]+/, '').split('/').reject! {|b| b.empty? || b.match(/^(\d)+$/) }
        return unless breadcrumbs

        last = breadcrumbs.last

        capture_haml do
          haml_tag :li do
            breadcrumbs_arrow
          end

          t = "backend.breadcrumbs"
          route = "/backend"

          breadcrumbs.each_with_index do |b, i|
            edit    = false
            content = false
            route += "/#{b}"

            haml_tag :li do
              if b.match(/edit/)
                edit = true
              elsif b.match(/new/)
                haml_tag :a, :href => "/backend/#{breadcrumbs[i-1]}/new" do
                  haml_concat I18n.t("#{t}.#{breadcrumbs[i-1]}_new")
                end
              else
                Content.subclasses.each do |s|
                  if s.to_s.tableize == b
                    haml_concat I18n.t("#{t}.add_content")
                    content = true
                  end
                end

                unless content
                  haml_tag :a, :href => route do
                    haml_concat I18n.t("#{t}.#{b}")
                  end
                end
              end

              breadcrumbs_arrow unless b == last
            end

            if edit
              if breadcrumbs[i-1].match(/contents/)
                breadcrumbs_obj_title I18n.t("#{t}.#{obj.type.to_s.tableize}_edit")
              else
                breadcrumbs_obj_title I18n.t("#{t}.#{breadcrumbs[i-1]}_edit")
              end
            end
          end
        end
      end

      def breadcrumbs_arrow
        haml_tag :span, :class => "divider" do
          haml_tag :span, :class => "icon16 icomoon-icon-arrow-right-2"
        end     
      end

      def breadcrumbs_obj_title(translation)
        haml_tag :li do
          haml_concat translation
        end

        haml_tag :li do
          haml_concat "- " + ( obj.has_attribute?( :title ) ? obj.title : obj.name )
        end
      end
    end
  end
end