module Mokio
  module Concerns
    module Common
      module SeoTags
        extend ActiveSupport::Concern

        included do
          has_many :seo_tags, as: :seo_tagable
          accepts_nested_attributes_for :seo_tags, reject_if: :all_blank, allow_destroy: true
        end

        module ClassMethods
          def has_seo_tagable_enabled?
            true
          end

          def seo_tagable_columns
            columns =  Mokio::SeoTag.seo_tags_list_keys
            columns - self.seo_tagable_custom_columns if self.respond_to?("seo_tagable_custom_columns")
            columns
          end

        end
      end
    end
  end
end