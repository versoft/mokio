module Mokio
  class Backend::MovGalleriesController < Backend::CommonController

    def create
      @mov_gallery = MovGallery.new(mov_gallery_params)

      respond_to do |format|
        if @mov_gallery.save
          if !params[:save_and_new].blank?
            format.html { redirect_to new_backend_mov_gallery_path, notice: t("mov_galleries.created_and_new", title: @mov_gallery.title) }
          else
            format.html { redirect_to edit_backend_content_path(@mov_gallery), notice: t("mov_galleries.created", title: @mov_gallery.title) }
          end
        else
          format.html { render "new", notice: t("mov_galleries.not_created", title: @mov_gallery) }
        end
      end
    end

    private
      def mov_gallery_params
        params.require(:mov_gallery).permit(:title, :type, :active, :intro, :content, :display_from, :display_to, :lang_id, :main_pic, :tag_list, :data_file => [], :meta_attributes => Meta.meta_attributes)
      end
  end
end