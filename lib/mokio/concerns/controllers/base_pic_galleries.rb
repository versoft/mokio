module Mokio
  module Concerns 
    module Controllers
      #
      # Concern for PicGalleriesController
      #
      module BasePicGalleries
        extend ActiveSupport::Concern

        included do
        end

        #
        # Overriten create from CommonController#create (Mokio::Concerns::Controllers::Common)
        #

        def set_breadcrumbs_prefix
          @breadcrumbs_prefix = "content_management"
          @breadcrumbs_prefix_link = "contents"
        end
        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def base_pic_gallery_params #:doc:
            params.require(:base_pic_gallery).permit(:title, :subtitle, :type, :active,:home_page, :intro, :content, :display_from, :display_to, :lang_id, :main_pic, :tag_list, :menu_ids => [], :data_file => [],
              :meta_attributes => Mokio::Meta.meta_attributes)
          end
      end
    end
  end
end