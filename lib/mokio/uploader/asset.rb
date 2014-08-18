module Mokio
  module Uploader #:nodoc:
    module Asset #:nodoc:
      def self.included(base)
        #
        # Include RMagick or MiniMagick support:
        #
        base.send :include, CarrierWave::RMagick
        base.send :include, CarrierWave::MiniMagick

        #
        # What kind of storage to use for this uploader:
        #
        base.storage :file

        #
        # Create different versions of your uploaded files:
        #
        base.version :normal do
          process :resize_to_limit => [Mokio.default_width, Mokio.default_height]
        end

        base.version :thumb do
          process :resize_to_limit => [Mokio.photo_thumb_width, Mokio.photo_thumb_height]
        end

        base.version :medium do
          process :resize_to_limit => [Mokio.photo_medium_width, Mokio.photo_medium_height]
        end

        base.version :big do
          process :resize_to_fill => [Mokio.photo_big_width, Mokio.photo_big_height]
        end

        #
        # Override the directory where uploaded files will be stored.
        # This is a sensible default for uploaders that are meant to be mounted:
        #
        def store_dir
          "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  end
end