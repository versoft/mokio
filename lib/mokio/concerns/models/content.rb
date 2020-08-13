module Mokio
  module Concerns
    module Models
      #
      # Concern for Content model
      #
      module Content
        extend ActiveSupport::Concern

        included do
          include Mokio::Concerns::Models::Common
          include Mokio::Concerns::Common::SeoTags
          include Mokio::Concerns::Common::Services::Sitemap::Model
          include Mokio::Concerns::Common::History::Model
          include Mokio::Sluglize

          has_many :content_links, :dependent => :destroy
          has_many :data_files, as: :imageable, dependent: :destroy
          has_many :menus, :through => :content_links

          belongs_to :gmap, :dependent => :destroy,optional: true # Relation with gmap isn't necessary !

          belongs_to :author, :class_name => 'Mokio::User', :foreign_key => :created_by, optional: true
          belongs_to :editor, :class_name => 'Mokio::User', :foreign_key => :updated_by, optional: true
          belongs_to :lang, required: false

          mount_uploader :main_pic, Mokio::MainPicUploader

          accepts_nested_attributes_for :menus
          accepts_nested_attributes_for :gmap,       :allow_destroy => true, :reject_if => lambda { |g| g[:full_address].blank? }
          accepts_nested_attributes_for :data_files, :allow_destroy => true, :reject_if => lambda { |d| d[:data_file].blank? }

          validates :title, presence: true
          validate :compare_dates

          scope :lang,          -> (lang_id) { where('lang_id = ? or lang_id is null', lang_id) }
          scope :order_default, -> { order("seq asc") }
          scope :active,        -> { where(active: true) }
          scope :_displayed_from, -> { where("display_from < ? OR display_from IS NULL", Time.zone.now) }
          scope :_displayed_to, -> { where("display_to > ? OR display_to IS NULL", Time.zone.now) }
          scope :displayed, -> { active._displayed_from._displayed_to}

          scope :order_created, -> { reorder(nil).order('created_at DESC') }

          before_save :update_display_to
          after_save :update_etag

          self.per_page = 15
        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            %w(title active type updated_at lang_id)
          end

          def backend_search_columns
            %w(title content)
          end

        end

        def slug_by_value
          self.title
        end

        def sitemap_url_strategy
          {
            loc: "#{self.slug}",
            priority: 1,
            lastmod: self.updated_at
          }
        end

        def can_add_to_sitemap?
          true
        end

        def author_name
          author.name_view unless author.blank?
        end

        def editor_name
          editor.name_view unless editor.blank?
        end

        #
        # Touching etag field
        #
        def update_etag
          self.touch(:etag)
        end


        #
        # Update display_to field: set time to 23:59:59 if time is set to 00:00:00
        #
        def update_display_to
          if self.display_to && self.display_to.time.strftime("%H:%M") == "00:00"
            updated = self.display_to.end_of_day
            self.display_to = updated
          end
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

        # @TODO - use gem for this

        #
        # Compare dates from display_from and display_to fields
        #
        def compare_dates
          if self[:display_from] && self[:display_to]
            if self[:display_from] > self[:display_to]
              errors.add(:display_from)
            end
          end
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
