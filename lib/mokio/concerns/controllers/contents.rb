module Mokio
  module Concerns
    module Controllers
      #
      # Concern for ContentsController
      #
      module Contents
        extend ActiveSupport::Concern

        included do
          include Mokio::Concerns::Controllers::MainPics
        end

        #
        # Overriten CommonController new (Mokio::Concerns::Controllers::Common)
        #
        def new
          redirect_to new_article_path
        end
      end
    end
  end
end