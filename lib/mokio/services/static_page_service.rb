module Mokio
  module Services
    class StaticPageService

      def initialize(params = {})
        @disable_sitemap_regenerate = params[:disable_sitemap_regenerate] || false
        @user = params[:user] || nil
        @using_paths = []
      end

      def call
        Rails.application.routes.routes.each do |route|
          if route.name
            if route.name.start_with?('static_')
              pathname = route.name
              method = route.verb.upcase

              next if method != 'GET' # add only GET paths

              if route.scope_options.blank?
                @using_paths << pathname
                path = eval("Rails.application.routes.url_helpers.#{pathname}_path")
                save_static_page(pathname, path)
              else
                route.scope_options.each do |key, options|
                  parsed_options = options.source.split('|')
                  parsed_options.each do |param|
                    system_name = "#{pathname}_#{param}"
                    @using_paths << system_name
                    path = eval("Rails.application.routes.url_helpers.#{pathname}_path(#{key.to_s}: '#{param}')")
                    save_static_page(pathname, path, system_name)
                  end
                end
              end
            end
          end
        end
        mark_pages_as_deleted
      end

      def save_static_page(pathname, path, system_name = nil)
        system_name = pathname if system_name.nil?
        static_page = Mokio::StaticPage.find_by(system_name: system_name)
        unless static_page
          static_page = Mokio::StaticPage.new({ system_name: system_name })
          static_page.author = @user
          static_page.sitemap_date = Time.now
        end
        static_page.pathname = pathname
        static_page.deleted_at = nil
        static_page.disable_sitemap_generator = @disable_sitemap_regenerate
        static_page.path = path
        static_page.save
      end

      def mark_pages_as_deleted
        # find and mark deleted paths
        StaticPage.all.each do |sp|
          unless @using_paths.include?(sp.system_name)
            sp.deleted_at = Time.now
            sp.save
          end
        end
      end

    end
  end
end
