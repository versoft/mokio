module Mokio
  module Concerns
    module Controllers
      #
      # Concern for PicGalleriesController
      #
      module PicGalleries
        extend ActiveSupport::Concern

        included do

          before_action :init_obj, :set_author, :only =>[:create]
          before_action :set_editor, :only => [:create, :update]

        end

        def init_obj
          @pic_gallery = Mokio::PicGallery.new(pic_gallery_params)
        end

        def set_author
          @pic_gallery.created_by = current_user.id
        end

        def set_editor
          obj.updated_by = current_user.id
          set_author if obj.created_by.blank? # for backward compatibility
        end

        #
        # Overriten create from CommonController#create (Mokio::Concerns::Controllers::Common)
        #
        def create
          respond_to do |format|
            if @pic_gallery.save
              if !params[:save_and_new].blank?
                format.html { redirect_to new_mov_gallery_path, notice: t("pic_galleries.created_and_new", title: @pic_gallery.title) }
              else
                format.html { redirect_to edit_content_path(@pic_gallery), notice: t("pic_galleries.created", title: @pic_gallery.title) }
              end
            else
              format.html { render "new", notice: t("pic_galleries.not_created", title: @pic_gallery) }
            end
          end
        end

        def set_breadcrumbs_prefix
          @breadcrumbs_prefix = "content_management"
          @breadcrumbs_prefix_link = "contents"
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def pic_gallery_params #:doc:
            params.require(:pic_gallery).permit(mokio_gems_parameters,:title, :subtitle, :type, :active,:home_page, :intro, :content, :display_from, :display_to, :lang_id, :main_pic, :tag_list, :menu_ids => [], :data_file => [])
          end
      end
    end
  end
end