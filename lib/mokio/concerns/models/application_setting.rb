module Mokio
  module Concerns
    module Models
      module ApplicationSetting
        extend ActiveSupport::Concern
        included do
          include Mokio::Concerns::Models::Common

          belongs_to :application_settings_group, optional: true

          validates_presence_of :name, :value
          validates_uniqueness_of :name

          def editable
            true
          end

          def name_view
            html = ""
            html << (
              ActionController::Base.helpers.link_to self.name,
              ApplicationController.helpers.edit_url(self.class.base_class, self)
            )
            html
          end

          def group_view
            group_id = self.mokio_application_settings_group_id
            html = ""
            if group_id.present?
              group = Mokio::ApplicationSettingsGroup.find(group_id)
              html << (
                ActionController::Base.helpers.link_to group.name,
                ApplicationController.helpers.edit_url(group.class.base_class, group)
              )
            end
            html
          end
        end

        module ClassMethods
          def get(name)
            val = self.all.find_by_name(name)
            unless val.nil?
              val.value
            end
          end

          def columns_for_table
            %w(name value description group)
          end
        end

      end
    end
  end
end
