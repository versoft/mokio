module Mokio
  module Concerns
    module Models
      #
      # Concern for StaticModule model
      #
      module StaticModule
        extend ActiveSupport::Concern

        included do
          include Mokio::Concerns::Models::Common

          has_and_belongs_to_many :module_positions, :join_table => "mokio_available_modules"
          accepts_nested_attributes_for :module_positions
          validates :title, presence: true
          
          #
          # include module_positions to amoeba duplication process
          #
          amoeba do
            include_field :module_positions
          end
        end

        module ClassMethods
          #
          # Columns for table in CommonController#index view
          #
          def columns_for_table
            ["title", "active", "module_position_ids", "updated_at", "lang_id"]
          end
        end

        #
        # Output for <b>module_position_ids</b> parameter, used in CommonController#index
        #
        def module_position_ids_view
          self.module_position_ids.map{|pos| Mokio::ModulePosition.find(pos).name}.join(', ')
        end

        #
        # Output for <b>title</b> parameter, used in CommonController#index
        #
        def title_view
          (ActionController::Base.helpers.link_to self[:title], ApplicationController.helpers.edit_url(self.class.base_class, self)).html_safe
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