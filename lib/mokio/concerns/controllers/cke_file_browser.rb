module Mokio
  module Concerns
    module Controllers

      module CkeFileBrowser
        extend ActiveSupport::Concern

        # list all files
        def index
          results = Mokio::Concerns::Common::Services::GetCkeFiles.new.call
          render json: results
        end

        def create
          if params[:files]
            params[:files].each do |file|
              uploader = Mokio::Uploader::CkeUploader.new
              uploader.store!(file)
            end
          end
          render json: { msg: 'ok' }
        end

        def destroy
          if params[:filename]
            uploader = Mokio::Uploader::CkeUploader.new
            uploader.retrieve_from_store!(params[:filename])
            uploader.remove!
            render json: { msg: 'ok' }
          else
            render json: { msg: 'file not defined' }, status: 422
          end
        end

      end
    end
  end
end