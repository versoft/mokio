module Mokio
  module Concerns #:nodoc:
    module Controllers #:nodoc:
      #
      # Concern for ArticlesController
      #
      module StaticPages
        extend ActiveSupport::Concern

        included do
          before_action :init_obj, :set_author, :only =>[:create]
          before_action :set_editor, :only => [:create, :update]
        end

        def index
          create_and_update_static_pages
          super
        end

        def create_and_update_static_pages
          using_paths = []
          Rails.application.routes.routes.each do |route|
            if route.name
              if route.name.start_with?('static_')
                pathname = route.name
                method = route.verb.upcase

                next if method != 'GET' # add only GET paths

                if route.scope_options.blank?
                  using_paths << pathname
                  path = eval("Rails.application.routes.url_helpers.#{pathname}_path")
                  save_static_page(pathname, path)
                else
                  route.scope_options.each do |key, options|
                    parsed_options = options.source.split('|')
                    parsed_options.each do |param|
                      system_name = "#{pathname}_#{param}"
                      using_paths << system_name
                      path = eval("Rails.application.routes.url_helpers.#{pathname}_path(#{key.to_s}: '#{param}')")
                      save_static_page(pathname, path, system_name)
                    end
                  end
                end
              end
            end
          end

          # find and mark deleted paths
          StaticPage.all.each do |sp|
            unless using_paths.include?(sp.system_name)
              sp.deleted_at = Time.now
              sp.save
            end
          end
        end

        def save_static_page(pathname, path, system_name = nil)
          system_name = pathname if system_name.nil?
          static_page = Mokio::StaticPage.find_by(system_name: system_name)
          unless static_page
            static_page = Mokio::StaticPage.new({ system_name: system_name })
            static_page.author = current_user
            static_page.sitemap_date = Time.now
          end
          static_page.pathname = pathname
          static_page.deleted_at = nil
          static_page.path = path
          static_page.save
        end

        #
        # Overriten create from CommonController#create (Mokio::Concerns::Controllers::Common)
        #
        def create
          respond_to do |format|
            if obj.save
              if !params[:save_and_new].blank?
                format.html { redirect_to obj_new_url(@obj_class.new), notice: Mokio::Concerns::Common::Translations::CommonTranslation.created(obj) }
                format.json { render action: 'new', status: :created, location: obj }
              else
                format.html { redirect_to obj_index_url, notice: Mokio::Concerns::Common::Translations::CommonTranslation.created(obj) }
                format.json { render action: 'index', status: :created, location: obj }
              end
            else
              format.html { render "new", notice: Mokio::Concerns::Common::Translations::CommonTranslation.not_created(obj) }
              format.json { render json: @obj.errors, status: :unprocessable_entity }
            end
          end
        end

        def init_obj
          create_obj( @obj_class.new(obj_params) )
        end

        def set_author
          obj.author = current_user
        end

        def set_editor
          obj.editor = current_user
          set_author unless obj.author # for backward compatibility
        end

        def set_breadcrumbs_prefix
          @breadcrumbs_prefix = "content_management"
          @breadcrumbs_prefix_link = "contents"
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def static_page_params #:doc:
            params.require(:static_page).permit(
              extended_parameters,mokio_gems_parameters,
              :pathname,
              :path,
              :automatic_date_update,
              :sitemap_date,
              :custom_field_1,
              :custom_field_2,
              :custom_field_3,
              :custom_field_4,
              :custom_field_5,
              :lang_id
            )
          end
      end
    end
  end
end
