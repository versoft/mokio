module Mokio
  module Concerns
    module Models
      module SeoTag

        extend ActiveSupport::Concern

        included do
          belongs_to :seo_tagable, polymorphic: true
        end

        module ClassMethods
          def seo_tag_attributes
            [:tag_key,:tag_value,:id,:_destroy]
          end

          def seo_tags_list_keys
            self.seo_tags_list.pluck(:key)
          end

          def seo_tags_list
            [
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
              { type: "name", key: "og:title"},
              { type: "name", key: "og:type"},
              { type: "name", key: "og:url"},
              { type: "name", key: "og:image"},
              { type: "name", key: "og:site_name"},
              { type: "name", key: "og:description"},
              { type: "name", key: "fb:page_id"},
              { type: "name", key: "og:email"},
              { type: "name", key: "og:phone_number"},
              { type: "name", key: "og:fax_number"},
              { type: "name", key: "og:latitude"},
              { type: "name", key: "og:longitude"},
              { type: "name", key: "og:street-address"},
              { type: "name", key: "og:locality"},
              { type: "name", key: "og:region"},
              { type: "name", key: "og:postal-code"},
              { type: "name", key: "og:country-name"},
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
