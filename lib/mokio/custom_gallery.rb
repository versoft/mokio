module Mokio
  module CustomGallery
    extend ActiveSupport::Concern

    included do
      has_many :data_files, class_name: "Mokio::DataFile", as: :imageable, dependent: :destroy
    end

    # Available options: Mokio::Photo, Mokio::Youtube
    def default_data_file
      Mokio::Photo
    end
    
    def gallery_title
      nil
    end

    module ClassMethods
      def has_gallery_enabled?
        true
      end
    end
  end
end