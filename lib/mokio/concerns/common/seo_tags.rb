module Mokio
  module Concerns
    module Common
      module SeoTags
        extend ActiveSupport::Concern

        included do
          has_many :seo_tags, as: :seo_tagable, :class_name => 'Mokio::SeoTag'
          accepts_nested_attributes_for :seo_tags, reject_if: :all_blank, allow_destroy: true
          after_create :create_default_meta

          private
          def create_default_meta
            if self.respond_to?(:auto_create_meta_tags)
              already_created_tags = []
              self.seo_tags.each do |st|
                already_created_tags << st.tag_key.downcase
              end
              auto_create_meta_tags.each do |dst|
                #dst = {key: "og:title", value: "value"}
                #check is already used:
                unless already_created_tags.include?(dst[:key].downcase)
                  founded_key = Mokio::SeoTag.find_key_in_seo_list(dst[:key])
                  next if founded_key.nil?
                  new_seo_tag = Mokio::SeoTag.create(
                    tag_value: dst[:value],
                    tag_key: founded_key
                  )
                  self.seo_tags << new_seo_tag
                end

              end
              self.save
            end
          end
        end

        module ClassMethods
          def has_seo_tagable_enabled?
            true
          end

          def render_label(name)
            el = Mokio::SeoTag.seo_tags_list.select{|value| value[:key] == name }
            "meta #{el[0][:type]}='#{el[0][:key]}'"
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