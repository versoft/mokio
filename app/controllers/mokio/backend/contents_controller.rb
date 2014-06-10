module Mokio
  class Backend::ContentsController < Backend::CommonController
    def new
      redirect_to new_backend_article_path
    end
  end
end