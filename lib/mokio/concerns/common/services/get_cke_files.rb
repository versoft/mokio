module Mokio
  module Concerns #:nodoc:
    module Common #:nodoc:
      module Services
        class GetCkeFiles
          include ActionView::Helpers::NumberHelper

          def initialize
            @directory_path = "#{Rails.root}/#{Mokio.cke_root_images_path}"
            @thumb_directory_path = "#{@directory_path}/thumbs"
            @web_path = Mokio.cke_root_images_path.gsub('public', '')
            @thumb_web_path = "#{@web_path}/thumbs"
          end

          def call
            files = Dir.glob("#{@directory_path}/*").select { |f| File.file?(f) }
            results = []
            files.each do |file_path|
              size = number_to_human_size(File.size(file_path))
              file_name = File.basename(file_path)
              is_thumb_exists = File.exist?(thumb_file_path(file_name))
              results << {
                thumb: is_thumb_exists ? web_thumb_file_path(file_name) : nil,
                path: web_file_path(file_name),
                file_name: file_name,
                size: size,
                created_at: File.ctime(file_path).strftime("%F %T")
              }
            end
            results
          end

          private

          def thumb_file_path(filename)
            "#{@thumb_directory_path}/thumb_#{filename}"
          end

          def web_thumb_file_path(filename)
            "#{@thumb_web_path}/thumb_#{filename}"
          end

          def web_file_path(filename)
            "#{@web_path}/#{filename}"
          end

        end
      end
    end
  end
end
