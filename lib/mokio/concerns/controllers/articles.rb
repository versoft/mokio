module Mokio
  module Concerns #:nodoc:
    module Controllers #:nodoc:
      #
      # Concern for ArticlesController
      #
      module Articles
        extend ActiveSupport::Concern

        included do

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
            params.require(:article).permit(extended_parameters,mokio_gems_parameters, :title, :subtitle, :intro, :content, :article_type, :home_page, :tpl, :contact, :active, :seq, :lang_id,
              :gallery_type, :display_from, :display_to, :main_pic, :tag_list,:menu_ids => [], :data_files_attributes => [:data_file, :main_pic, :id, :remove_data_file]
            )
          end
      end
    end
  end
end