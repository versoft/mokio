module Mokio
  module Concerns
    module Controllers
      #
      # Concern for MovGalleriesController
      #
      module MovGalleries
        extend ActiveSupport::Concern

        included do
        end

        #
        # Overriten create from CommonController#create (Mokio::Concerns::Controllers::Common)
        #
        def create
          @mov_gallery = Mokio::MovGallery.new(mov_gallery_params)

          respond_to do |format|
            if @mov_gallery.save
              if !params[:save_and_new].blank?
                format.html { redirect_to new_mov_gallery_path, notice: t("mov_galleries.created_and_new", title: @mov_gallery.title) }
              else
                format.html { redirect_to edit_content_path(@mov_gallery), notice: t("mov_galleries.created", title: @mov_gallery.title) }
              end
            else
              format.html { render "new", notice: t("mov_galleries.not_created", title: @mov_gallery) }
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
          def mov_gallery_params #:doc:
            params.require(:mov_gallery).permit(:title, :subtitle, :type, :active, :home_page ,:intro, :content, :display_from, :display_to, :lang_id, :main_pic, :tag_list, :menu_ids => [], :data_file => [],
              :meta_attributes => Mokio::Meta.meta_attributes)
          end
      end
    end
  end
end