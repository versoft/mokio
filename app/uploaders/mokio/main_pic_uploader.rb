module Mokio
  class MainPicUploader < CarrierWave::Uploader::Base
    include Mokio::Uploader::Asset
    
    version :edit, :if => :picgallery? do
      process :resize_to_fill => [100, 100]
    end

    def picgallery? image
      model.type == "PicGallery" if model.respond_to?(:type)
    end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w(jpg jpeg gif png)
    end
  end
end
