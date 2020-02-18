module Mokio
  module Concerns
    module Models
      module SeoTag

        extend ActiveSupport::Concern

        included do
          belongs_to :seo_tagable, polymorphic: true
          validates_uniqueness_of :tag_key, :scope => [:seo_tagable_type, :seo_tagable_id], case_sensitive: true

          def is_title?
            tag_key == "title"
          end

        end

        module ClassMethods

          def find_key_in_seo_list(default_key)
            selected_tag = Mokio::SeoTag.seo_tags_list.select { |t| t[:key].downcase == default_key.downcase }
            if(selected_tag.any?)
              selected_tag.first[:key]
            else
              nil
            end
          end

          def seo_tag_attributes
            [:tag_key, :tag_value, :id, :_destroy]
          end

          def seo_tags_list_keys
            self.seo_tags_list.pluck(:key)
          end

          def seo_tags_list
            [
              { type: "name", key: "title"},
              { type: "name", key: "keywords"},
              { type: "name", key: "description"},
              { type: "name", key: "subject"},
              { type: "name", key: "copyright"},
              { type: "name", key: "language"},
              { type: "name", key: "robots"},
              { type: "name", key: "revised"},
              { type: "name", key: "abstract"},
              { type: "name", key: "topic"},
              { type: "name", key: "summary"},
              { type: "name", key: "Classification"},
              { type: "name", key: "author"},
              { type: "name", key: "designer"},
              { type: "name", key: "copyright"},
              { type: "name", key: "reply-to"},
              { type: "name", key: "owner"},
              { type: "name", key: "url"},
              { type: "name", key: "identifier-URL"},
              { type: "name", key: "directory"},
              { type: "name", key: "category"},
              { type: "name", key: "coverage"},
              { type: "name", key: "distribution"},
              { type: "name", key: "rating"},
              { type: "name", key: "revisit-after"},
              { type: "name", key: "microid"},
              { type: "name", key: "apple-mobile-web-app-capable"},
              { type: "name", key: "apple-touch-fullscreen"},
              { type: "name", key: "apple-mobile-web-app-status-bar-style"},
              { type: "name", key: "format-detection"},
              { type: "name", key: "mssmarttagspreventparsing"},
              { type: "name", key: "msapplication-starturl"},
              { type: "name", key: "msapplication-window"},
              { type: "name", key: "msapplication-navbutton-color"},
              { type: "name", key: "application-name"},
              { type: "name", key: "msapplication-tooltip"},
              { type: "name", key: "msapplication-task"},
              { type: "name", key: "tweetmeme-title"},
              { type: "name", key: "apple-mobile-web-app-capable"},
              { type: "name", key: "apple-mobile-web-app-status-bar-style"},
              { type: "name", key: "format-detection"},
              { type: "name", key: "viewport"},

              { type: "property", key: "og:title"},
              { type: "property", key: "og:url"},
              { type: "property", key: "og:image"},
              { type: "property", key: "og:site_name"},
              { type: "property", key: "og:description"},
              { type: "property", key: "fb:page_id"},
              { type: "property", key: "og:email"},
              { type: "property", key: "og:phone_number"},
              { type: "property", key: "og:fax_number"},
              { type: "property", key: "og:latitude"},
              { type: "property", key: "og:longitude"},
              { type: "property", key: "og:street-address"},
              { type: "property", key: "og:locality"},
              { type: "property", key: "og:region"},
              { type: "property", key: "og:postal-code"},
              { type: "property", key: "og:country-name"},
              { type: "property", key: "og:type" },
              { type: "property", key: "og:points" },
              { type: "property", key: "og:video" },
              { type: "property", key: "og:video:height" },
              { type: "property", key: "og:video:width" },
              { type: "property", key: "og:video:type" },
              { type: "property", key: "og:video" },
              { type: "property", key: "og:video:type" },
              { type: "property", key: "og:video" },
              { type: "property", key: "og:video:type"},
              { type: "property", key: "og:audio" },
              { type: "property", key: "og:audio:title" },
              { type: "property", key: "og:audio:artist" },
              { type: "property", key: "og:audio:album" },
              { type: "property", key: "og:audio:type" },

              { type: "http-equiv", key: "Page-Enter"},
              { type: "http-equiv", key: "Page-Exit"},
              { type: "http-equiv", key: "X-UA-Compatible"},
              { type: "http-equiv", key: "Expires"},
              { type: "http-equiv", key: "Pragma"},
              { type: "http-equiv", key: "Cache-Control"},
            ]

          end
        end
      end
    end
  end
end
