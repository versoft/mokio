module Mokio
  class DataFileUploader < CarrierWave::Uploader::Base
    include Mokio::Uploader::Asset
    
    process :watermark => Mokio.watermark_path, :if => :create_watermark?

    protected

      def create_watermark? image
        Mokio.enable_watermark
      end

      def watermark(path_to_file)
        manipulate! do |img|
          img = img.composite(MiniMagick::Image.open(path_to_file), "jpg") do |c|
            c.gravity "SouthEast"
          end
        end
      end

      def picgallery? image
        Content.find(model.content_id).type == "PicGallery"
      end
  end
end
