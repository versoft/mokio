module Mokio
  module Concerns
    module Models
      #
      # Concern for Meta model
      #
      module Meta
        extend ActiveSupport::Concern

        included do
          has_many :menus
          has_many :contents

          accepts_nested_attributes_for :contents
          accepts_nested_attributes_for :menus

          after_save :touch_many
        end

        module ClassMethods
          def meta_attributes
            [:g_title, :g_desc, :g_keywords, :g_author, :g_copyright, :g_application_name, :f_title, :f_type, :f_image, :f_url, :f_desc, :id]
          end
        end

        #
        # Touching etag after updating meta
        #
        def touch_many
          menu    = Mokio::Menu.find_by_meta_id(self.id)
          content = Mokio::Content.find_by_meta_id(self.id)
          
          menu.touch if menu
          content.touch(:etag) if content
        end
      end
    end
  end
end