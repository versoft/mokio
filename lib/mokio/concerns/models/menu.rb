module Mokio
  module Concerns
    module Models
      #
      # Concern for Menu model
      #
      module Menu
        extend ActiveSupport::Concern

        included do
          include Mokio::Concerns::Models::Common
          extend FriendlyId

          friendly_id :slug_candidates, use: :slugged

          has_ancestry :orphan_strategy => :adopt

          validates :name, presence: true
          validates :lang_id, presence: true
          validates_uniqueness_of :slug

          belongs_to :lang
          belongs_to :meta, :dependent => :destroy

          mount_uploader :main_pic, Mokio::MainPicUploader

          has_many :content_links,     -> {order('mokio_content_links.seq')}, :dependent => :destroy
          has_many :contents,          -> {order('mokio_content_links.seq')},    :through => :content_links
          has_many :selected_modules,  -> {order('mokio_selected_modules.seq')}
          has_many :available_modules, -> {order('mokio_selected_modules.seq')}, :through => :selected_modules

          accepts_nested_attributes_for :contents, :available_modules
          accepts_nested_attributes_for :meta

          before_save :seq_and_lang_update

          after_save :touch_content
          after_destroy :touch_content

          scope :order_default, -> { order("seq asc") }
          scope :active,        -> { where(active: true) }
          scope :nofake,        -> { where(fake: false)}
          scope :fake_structure_unique, -> { where(fake: true) }

          def should_generate_new_friendly_id?
            name_changed?
          end

          if Mokio.solr_enabled
            ## For Sunspot Solr:
            searchable do ## Columns where Sunspot knows which data use to index
              text :name
            end
            ##
          end
        end

        module ClassMethods
          #
          # Columns for table - needed for coping a menu
          #
          def columns_for_table
            %w(name active updated_at lang_id)
          end
        end


        #
        # Friendly_id slug_candidates (<b>gem 'friendly_id'</b>)
        #
        def slug_candidates
          [
              :name,
              [build_slug, :name]
          ]
        end

        def build_slug
          if parent.nil?
            ''
          elsif !parent.fake
            parent.slug
          else
            parent.name
          end
        end
        #
        # Updating seq and lang_id fields
        #
        def seq_and_lang_update
          self.seq = sequence_number
          if self.lang_id.nil?
            self.lang_id = root.lang_id
          else
            self.lang_id = self.root.lang_id
          end
        end

        #
        # Returns list of contents available for assignment to given menu element (based on lang_id) ordered by title
        #
        def available_contents
          raise "NoLangDefinedException" if Mokio::Lang.count < 1
          if lang_id.nil? || lang_id == 0
            Mokio::Content.lang(Mokio::Lang.first.id).order(:title) - contents
          else
            Mokio::Content.lang(lang_id).order(:title) - contents
          end
        end

        def parent_root
          root = Mokio::Menu.find_by_lang_id(lang_id) unless lang_id.nil?
          root = Mokio::Menu.find_by_lang_id(Mokio::Lang.first.id) if root.nil?
          root
        end

        #
        # Return parent subtree
        #
        def parent_tree
          tree = parent_root.subtree
          tree.to_a.delete(self)
          tree.to_a.delete(parent_root)
          tree
        end

        #
        # Returns list of selected modules divided by positions
        #
        def selected_modules_by_pos
          # AvailableModule.selected_for_menu(id).group_by(&:module_position_id)
          (self.available_modules + Mokio::AvailableModule.always_displayed).uniq.group_by(&:module_position_id)
        end

        #
        # Returns list of static modules available for assignment to given menu menu element - divided per positions
        #
        def available_modules_by_pos
          menu_id = (self.id.nil? ? -1 : self.id)
          if lang_id.nil? || lang_id == 0
            Mokio::AvailableModule.not_selected_for_menu(menu_id).for_lang(Mokio::Lang.first.id).group_by(&:module_position_id)
          else
            Mokio::AvailableModule.not_selected_for_menu(menu_id).for_lang(lang_id).group_by(&:module_position_id)
          end
        end

        #
        # Return static modules for menu, does not include always displayed modules
        #
        def static_modules
          Mokio::StaticModule.where(:id => self.available_modules.map(&:static_module_id))
        end

        def sequence_number
          if seq.nil?
            if parent.nil?
              Mokio::Menu.where('ancestry is null').count +1
            else
              max = parent.children.maximum(:seq)
              max.nil? ? 1 : max + 1
            end
          else
            seq
          end
        end

        #
        # Checks if menu has any non-active or non-visible content assigned
        #
        def invisible_content
          contents.each do |content|
            if !content.active or !content.displayed?
              return true
            end
          end
          false
        end

        def content_type
          if contents.length > 1
            I18n.t('menus.list').titleize
          elsif contents.length == 1
            I18n.t(contents[0].type.underscore).titleize
          elsif !external_link.blank?
            I18n.t('external_link', Menu).titleize
          else
            ''
          end
        end

        #
        # Returns always editable fields
        #
        def always_editable_fields
          @always = %w(active seq visible always_displayed ancestry)
          @always << 'contents' if self.content_editable
          @always << 'available_modules' if self.modules_editable
          @always
        end

        #
        # Hierarchical slug
        #
        def full_slug
          m = self
          slug = m.slug
          unless m.parent.nil? || slug.nil?
            while m.parent && !m.parent.fake
              slug = m.parent.slug + "/" + slug
              m = m.parent
            end
            slug
          end
          slug
        end

        # Real slug - menu slug hierarchical or not, with lang prefix or not

        def real_slug (hierarchical)
          "/#{hierarchical ? full_slug : slug}"
        end

        #
        # Just for easier logic
        #
        def title
          self.name
        end

        #
        # First content on menu list
        #
        def content
          self.contents.active.first
        end

        #
        # Update etag for Content records after updating menu
        #
        def touch_content
          Mokio::Content.all.each do |c|
            c.touch(:etag)
          end
        end

        def one_content?
          self.contents.count == 1
        end

        def many_contents?
          self.contents.count > 1
        end

        #
        # Returns type of content added to menu
        #
        def linked_content_type
          return nil unless self.contents

          type = ""
          self.contents.each_with_index do |content, i|
            if i == 0
              type = content.type
            else
              return "mixed_content" if type != content.type
              type = content.type
            end
          end

          type.tableize
        end

      end
    end
  end
end