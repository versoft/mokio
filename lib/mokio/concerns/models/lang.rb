module Mokio
  module Concerns
    module Models
      #
      # Concern for Lang model
      #
      module Lang extend ActiveSupport::Concern
        # included do
        #   scope :default, -> {where(shortname: Mokio.frontend_default_lang).first}
        # end
          included do
            include Mokio::Concerns::Models::Common

            validates :name, presence: true
            validates_uniqueness_of :shortname, presence: true
            has_many :menu,:dependent => :delete_all

            after_update :update_menu_name
            after_create :add_fake_menu
            before_destroy :validate_last
            if Mokio.solr_enabled
              searchable do
                text :name
                text :shortname
              end
            end

            # scope :default, -> {where(shortname: Mokio.frontend_default_lang).first}
           end

        module ClassMethods

          def default
            Mokio::Lang.where(shortname: Mokio.frontend_default_lang).first
          end

          def default_frontend
            Mokio::Lang.where(shortname: Mokio.frontend_default_lang).first
          end
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            ["name","shortname","active"]
          end

        end

        def editable  #:nodoc:
          true
        end

        def deletable  #:nodoc:
          true
        end

        def name_view
          (ActionController::Base.helpers.link_to self[:name], ApplicationController.helpers.edit_url(self.class.base_class, self)).html_safe
        end

      #
      # Specify what's showed in breadcrumb
      #
      def breadcrumb_name
        name
      end

        private

        def add_fake_menu

          @menu = Mokio::Menu.new( name: self.shortname , lang_id: self.id,fake:true,deletable:false,editable:false)
          @menu.build_meta

          if(@menu.save)
            result = Mokio::Menu.all.fake_structure_unique
            result.each do |s|
              if s.depth == 1
                  @parent_menu = Mokio::Menu.new( name: s.name,ancestry:@menu.id, lang_id:self.id,fake:true,deletable:false,editable:false)
                  @parent_menu.save
                end
            end
          end
        end

        def validate_last
          if Mokio::Lang.count > 1
            #TODO
            return true
          else
            return false
          end
        end

        def update_menu_name
          a = Mokio::Menu.find_by_id(self.menu_id)
          a.name = self.shortname
          a.save(:validate => false)
        end
      end
    end
  end
end


