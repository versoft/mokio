module Mokio
  module Concerns
    module Models
      #
      # Concern for Gmap model
      #
      module EditableBlock
        extend ActiveSupport::Concern
        included do
          # include Mokio::Concerns::Common::History::Model
          belongs_to :author, :class_name => 'Mokio::User', optional: true
          belongs_to :editor, :class_name => 'Mokio::User', optional: true
          validates :hash_id, uniqueness: { scope: :lang }
          validates :hash_id, presence: true, allow_blank: false

          def update_location(path)
            new_location = Mokio::FrontendEditor::EditorPanel.location(path)
            location = self.location
            location ||= ''
            unless location.include?(new_location)
              self.location = "#{location} #{new_location}".strip
              self.save
            end
          end
        end

        module ClassMethods
          def find_blocks_by_lang_and_location(lang, path)
            location = Mokio::FrontendEditor::EditorPanel.location(path)
            Mokio::EditableBlock.where(
              'lang LIKE :lang AND location LIKE :location',
              { lang: lang, location: "%#{location}%" }
            )
          end
        end
      end
    end
  end
end
