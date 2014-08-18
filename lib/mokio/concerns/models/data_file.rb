module Mokio
  module Concerns
    module Models
      #
      # Concern for DataFile model
      #
      module DataFile
        extend ActiveSupport::Concern

        included do
          extend FriendlyId

          friendly_id :name, use: :slugged

          belongs_to :contents, :touch => true
          
          mount_uploader :data_file, Mokio::DataFileUploader
          mount_uploader :thumb,     Mokio::ThumbUploader

          scope :active,        -> { where(active: true) }
          scope :order_default, -> { order("seq asc") }

          #
          # For some reason touch => true does not work for DataFile :(
          #
          after_save :touch_content
          after_destroy :touch_content
          after_touch :touch_content

          before_create :default_name
          before_save :change_slug
        end

        #
        # Changing slug
        #
        def change_slug
          self.slug = self.name.parameterize unless self.name.blank?
        end

        #
        # Setting default name for file
        #
        def default_name
          self.name ||= File.basename(data_file.filename, '.*').titleize if data_file.filename && !self.name
        end

        #
        # Returns underscored file name
        #
        def name_underscored
          self.name.gsub(' ', '_')
        end

        #
        # For some reason touch => true does not work for DataFile :(
        #
        def touch_content
          Mokio::Content.find(self.content_id).touch(:etag)
        end

        def slide?
          false
        end
      end
    end
  end
end