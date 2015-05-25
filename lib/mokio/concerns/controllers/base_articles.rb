module Mokio
  module Concerns #:nodoc:
    module Controllers #:nodoc:
      #
      # Concern for ArticlesController
      #
      module BaseArticles
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

          def base_article_params #:doc:
            params.require(:base_article).permit(base_attributes,:contents_attributes => content_attributes)
          end
      end
    end
  end
end