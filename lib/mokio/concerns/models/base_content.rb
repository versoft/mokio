module Mokio
  module Concerns
    module Models
      #
      # Concern for Content model
      #
      module BaseContent
        extend ActiveSupport::Concern

        included do
          include Mokio::Concerns::Models::Common

          has_many :data_files, :dependent => :destroy, :foreign_key => :base_content_id
          has_many :contents ,:dependent => :destroy

          # validates :title, presence: true
          # validate :contents
          accepts_nested_attributes_for :contents
          accepts_nested_attributes_for :data_files, :allow_destroy => true, :reject_if => lambda { |d| d[:data_file].blank? }

          mount_uploader :main_pic, Mokio::MainPicUploader
          after_save :update_etag

        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            %w(title)
          end
        end

        def update_etag
          self.touch(:etag)
        end

        def editable
          true
        end

        def deletable
          true
        end


      end
    end
  end
end