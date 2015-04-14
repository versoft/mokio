module Mokio
  module Concerns #:nodoc:
    module Controllers #:nodoc:
      #
      # Concern for ArticlesController
      #
      module Articles
        extend ActiveSupport::Concern

        included do

          before_action :init_obj, :set_author, :only =>[:create]
          before_action :set_editor, :only => [:create, :update]

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
          obj.created_by = current_user.id
        end

        def set_editor
          obj.updated_by = current_user.id
          set_author if obj.created_by.blank? # for backward compatibility
        end


        def set_breadcrumbs_prefix
          @breadcrumbs_prefix = "content_management"
          @breadcrumbs_prefix_link = "contents"
        end


        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def article_params #:doc:
            params.require(:article).permit( extended_parameters, :title, :subtitle, :intro, :content, :article_type, :home_page, :tpl, :contact, :active, :seq, :lang_id,
              :gallery_type, :display_from, :display_to, :main_pic, :tag_list, :menu_ids => [], :data_files_attributes => [:data_file, :main_pic, :id, :remove_data_file]
            )
          end
      end
    end
  end
end