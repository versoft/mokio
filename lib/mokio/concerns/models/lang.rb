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

            validates :name ,presence: true , :on => :create
            validates :shortname , presence: true , :on => :create

            has_many :menu ,:dependent => :delete_all
            after_create :add_fake_menu
            before_destroy :validate_last
            

            # scope :default, -> {where(shortname: Mokio.frontend_default_lang).first}
           end

        module ClassMethods
          def default
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
          menu = Array.new
          @menu = Mokio::Menu.new( name: self.shortname , lang_id: self.id,fake:true,deletable:false,editable:false)
          @menu.build_meta
          if(@menu.save)
            result = Mokio::Menu.fake_structure_unique
            result.each do |pos|
              menu = Mokio::Menu.new( name: pos.name,ancestry:@menu.id, lang_id:self.id,fake:true,deletable:false,editable:false)
              menu.save(:validate => false)
            end
          end
        end


        def validate_last
          if Mokio::Lang.count > 1
            return true
          else
            return false
          end
        end
      end
    end
  end
end


