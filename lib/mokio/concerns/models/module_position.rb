module Mokio
  module Concerns
    module Models
      #
      # Concern for ModulePosition model
      #
      module ModulePosition  extend ActiveSupport::Concern

        include Mokio::Concerns::Models::Common
        included do
          has_and_belongs_to_many :static_modules, :join_table => "mokio_available_modules"
          accepts_nested_attributes_for :static_modules
          validates :name , presence: true
          amoeba do
            include_association :static_modules
          end
        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            ["name"]
          end
        end

        def name_view
          (ActionController::Base.helpers.link_to self[:name], ApplicationController.helpers.edit_url(self.class.base_class, self)).html_safe
        end

        def editable
          true
        end

        def deletable
          true
        end

      #
      # Specify what's showed in breadcrumb
      #
      def breadcrumb_name
        name
      end

      end
    end
  end
end