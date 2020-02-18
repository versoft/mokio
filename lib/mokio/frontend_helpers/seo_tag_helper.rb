module Mokio
  module FrontendHelpers
    #
    # Frontend helper methods used with Mokio::SeoTag objects
    #
    module SeoTagHelper
      def render_seo_meta_tags(model_obj)
        result = ""
        return result unless model_obj.class.has_seo_tagable_enabled?

        collection = model_obj.seo_tags
        processed_tags = []
        if collection.any?
          collection.each do |seo_tag|
            processed_tags << seo_tag.tag_key.downcase
            result << render_seo_meta_build_tag_helper(seo_tag)
          end
        end

        if model_obj.respond_to?(:default_seo_tags)
          model_obj.default_seo_tags.each do |dst|
            #dst = {key: "og:title", value: "value"}
            #check is already used:
            unless processed_tags.include?(dst[:key].downcase)
              founded_key = Mokio::SeoTag.find_key_in_seo_list(dst[:key])
              next if founded_key.nil?
              new_seo_tag = Mokio::SeoTag.new(
                tag_value: dst[:value],
                tag_key: founded_key
              )
              result << render_seo_meta_build_tag_helper(new_seo_tag)
            end

          end
        end
        result
      end

      private

      def render_seo_meta_build_tag_helper(seo_tag)
        seo_hash =  {}
        Mokio::SeoTag.seo_tags_list.map{|a| seo_hash[a[:key].to_sym] = a[:type]}
        return nil unless seo_tag.present? && seo_hash.present?
        if seo_tag.is_title?
          content_tag(:title, seo_tag.tag_value)
        else
          tag(:meta, "#{seo_hash[seo_tag.tag_key.to_sym]}" => ("#{seo_tag.tag_key}"), :content => ("#{seo_tag.tag_value}"))
        end
      end
    end
  end
end
