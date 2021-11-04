module Mokio
  module Uploader #:nodoc:
    class CkeUploader < CarrierWave::Uploader::Base
      storage :file

      include CarrierWave::MiniMagick

      version :thumb, :if => :image? do
        process resize_to_fit: [170, 170]

        def store_dir
          'files/thumbs'
          "#{Rails.root}/#{Mokio.cke_root_images_path}/thumbs"
        end

        def filename
          if self.parent_version
            parent_file_name = self.parent_version.to_s
            unless parent_file_name.blank?
              return File.basename(parent_file_name)
            end
          end
          original_filename if original_filename.present?
        end
      end

      def filename
        if original_filename.present?
          extension = File.extname(original_filename)
          basename = File.basename(original_filename, extension)
          if already_exists?(original_filename)
            hash = SecureRandom.hex(3)
            new_name = "#{basename}-#{hash}#{extension}"
            if already_exists?(new_name)
              hash = SecureRandom.hex(3)
              new_name = "#{basename}-#{hash}#{extension}"
            end
            return new_name
          else
            return original_filename
          end
        end
      end

      def image?(carrier_wave_sanitized_file)
        ext = carrier_wave_sanitized_file.extension
        ['png', 'jpg', 'jpeg', 'PNG', 'JPG', 'JPEG'].include?(ext)
      end

      def store_dir
        "#{Rails.root}/#{Mokio.cke_root_images_path}"
      end

      def already_exists?(filename)
        path = "#{Rails.root}/#{Mokio.cke_root_images_path}/#{filename}"
        File.exist?(path)
      end

    end
  end
end
