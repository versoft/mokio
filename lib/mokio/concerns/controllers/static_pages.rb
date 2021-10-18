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
          # create and update static pages
          Mokio::Services::StaticPageService.new.call
          super
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
                format.html { redirect_to obj_edit_url(obj), notice: Mokio::Concerns::Common::Translations::CommonTranslation.created(obj) }
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
