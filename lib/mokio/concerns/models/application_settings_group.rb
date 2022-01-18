module Mokio
  module Concerns
    module Models
      module ApplicationSettingsGroup
        extend ActiveSupport::Concern
        included do
          include Mokio::Concerns::Models::Common

          has_many :application_settings
          validates_presence_of :name
          validates_uniqueness_of :name

          def editable
            true
          end

          def deletable
            true
          end

          def name_view
            html = ""
            html << (ActionController::Base.helpers.link_to self.name, ApplicationController.helpers.edit_url(self.class.base_class, self))
            html
          end
        end

        module ClassMethods
          def columns_for_table
            %w(name)
          end
        end

      end
    end
  end
end
