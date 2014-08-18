module Mokio
  module Concerns 
    module Controllers
      #
      # Concern for PicGalleriesController
      #
      module PicGalleries
        extend ActiveSupport::Concern

        included do
        end

        #
        # Overriten create from CommonController#create (Mokio::Concerns::Controllers::Common)
        #
        def create
          @pic_gallery = Mokio::PicGallery.new(pic_gallery_params)

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

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def pic_gallery_params #:doc:
            params.require(:pic_gallery).permit(:title, :type, :active, :intro, :content, :display_from, :display_to, :lang_id, :main_pic, :tag_list, :menu_ids => [], :data_file => [],
              :meta_attributes => Mokio::Meta.meta_attributes)
          end
      end
    end
  end
end