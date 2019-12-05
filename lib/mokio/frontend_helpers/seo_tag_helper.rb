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

        if collection.any?
          seo_hash =  {}

          Mokio::SeoTag.seo_tags_list.map{|a| seo_hash[a[:key].to_sym] = a[:type] }

          collection.each do |el|
            result << render_seo_meta_build_tag_helper(el,seo_hash)
          end
        end
        result
      end

      private

      def render_seo_meta_build_tag_helper(el,seo_hash)
        return nil unless el.present? && seo_hash.present?
        tag(:meta, "#{seo_hash[el.tag_key.to_sym]}" => ("#{el.tag_key}"),:content => ("#{el.tag_value}"))
      end
    end
  end
end
