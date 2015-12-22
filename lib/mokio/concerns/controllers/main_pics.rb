module Mokio
  module Concerns
    module Controllers
      #
      # Concern for ContentsController
      #
      module MainPics
        extend ActiveSupport::Concern

        included do

          def delete_main_pic
            obj = Mokio::Content.find(params[:id])
            obj.remove_main_pic!
            
            if obj.save!
              flash[:notice] = t("main_pics.deleted")
            else
              flash[:error] = t("main_pics.not_deleted")
            end

            respond_to do |format|
              format.js
            end
          end

        end

      end
    end
  end
end