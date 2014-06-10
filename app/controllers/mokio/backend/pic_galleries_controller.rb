module Mokio
  class Backend::PicGalleriesController < Backend::CommonController

    def create
      @pic_gallery = PicGallery.new(pic_gallery_params)

      respond_to do |format|
        if @pic_gallery.save
          if !params[:save_and_new].blank?
            format.html { redirect_to new_backend_mov_gallery_path, notice: t("pic_galleries.created_and_new", title: @pic_gallery.title) }
          else
            format.html { redirect_to edit_backend_content_path(@pic_gallery), notice: t("pic_galleries.created", title: @pic_gallery.title) }
          end
        else
          format.html { render "new", notice: t("pic_galleries.not_created", title: @pic_gallery) }
        end
      end
    end

    private
      def pic_gallery_params
        params.require(:pic_gallery).permit(:title, :type, :active, :intro, :content, :display_from, :display_to, :lang_id, :main_pic, :tag_list, :data_file => [], :meta_attributes => Meta.meta_attributes)
      end
  end
end