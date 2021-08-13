module Mokio
  module Concerns
    module Models #:nodoc:
      #
      # Concern for Mokio::StaticPage model
      #
      module StaticPage
        extend ActiveSupport::Concern

        included do
          # include Mokio::Concerns::Models::Common
          include ActiveModel::Dirty
          include Mokio::Concerns::Common::SeoTags
          include Mokio::Concerns::Common::Services::Sitemap::Model
          include Mokio::Concerns::Common::History::Model
          before_save :update_sitemap_date

          has_many :data_files, as: :imageable, dependent: :destroy

          belongs_to :author, :class_name => 'Mokio::User', optional: true
          belongs_to :editor, :class_name => 'Mokio::User', optional: true
          belongs_to :lang, required: false

          accepts_nested_attributes_for :data_files, :allow_destroy => true, :reject_if => lambda { |d| d[:data_file].blank? }

          validates :path, :pathname, presence: true

          scope :lang,          -> (lang_id) { where('lang_id = ? or lang_id is null', lang_id) }
          scope :active,        -> { where(active: true) }
          scope :order_created, -> { reorder(nil).order('created_at DESC') }

          self.per_page = 15
        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            %w(path pathname system_name deleted_label)
          end

          def backend_search_columns
            %w(title content)
          end

          def has_historable_enabled?
            true
          end

          def hide_index_add_button
            true
          end

          def has_gmap_enabled?
            false
          end

          # uncomment to enable photo gallery
          # def has_gallery_enabled?
          #   true
          # end
        end

        # uncomment to enable photo gallery
        # def default_data_file
        #   Mokio::Photo
        # end

        def mokio_preview_link_in_edit_page
          self.path
        end

        def has_historable_enabled?
          true
        end

        def editable
          true
        end

        def deleted_label
          if deleted_at.nil?
            I18n.t('static_pages.labels.active')
          else
            I18n.t('static_pages.labels.deleted')
          end
        end

        def deletable
          !deleted_at.nil?
        end

        def update_sitemap_date
          seo_tags_changed = self.seo_tags.any? {|a| a.changed?}
          if automatic_date_update && (self.changed? ||seo_tags_changed)
            self.sitemap_date = Time.now
          end
        end

        def cloneable?
          false
        end

        def sitemap_url_strategy
          {
            loc: self.path,
            priority: 1,
            lastmod: self.sitemap_date
          }
        end

        def can_add_to_sitemap?
          true
        end

        def title
          pathname
        end

        def name
          pathname
        end

        def author_name
          author.name_view unless author.blank?
        end

        def editor_name
          editor.name_view unless editor.blank?
        end

        #
        # Output for title field
        #
        def title_view
          html = ""
          html << "<span class=\"icon12 icomoon-icon-home home_page\"></span>" if self[:home_page]
          html << (ActionController::Base.helpers.link_to self[:title], ApplicationController.helpers.edit_url(self.class.base_class, self))
          html.html_safe
        end

        #
        # Output for type field
        #
        def type_view
          I18n.t("contents.types.#{self[:type]}")
        end

        #
        # Specify what's showed in breadcrumb
        #
        def breadcrumb_name
          title
        end

      end
    end
  end
end
