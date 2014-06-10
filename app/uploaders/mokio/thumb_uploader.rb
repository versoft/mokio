module Mokio
  class ThumbUploader < CarrierWave::Uploader::Base
    include Mokio::Uploader::Asset
    
    def is_new? image
      model.thumb.blank?
    end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w(jpg jpeg gif png)
    end
  end
end
