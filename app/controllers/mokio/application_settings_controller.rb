module Mokio
  class ApplicationSettingsController < Mokio::CommonController
    include ActiveSupport::Concern

    def index
      Mokio.application_settings_defaults.each do |s|
        if s[:group].present?
          group = Mokio::ApplicationSettingsGroup.where(name: s[:group]).first
          group = Mokio::ApplicationSettingsGroup.create!(name: s[:group]) unless group.present?
          s.merge!({mokio_application_settings_group_id: group.id})
        end

        unless Mokio::ApplicationSetting.where(name: s[:name]).present?
          s.delete(:group)
          Mokio::ApplicationSetting.create!(s)
        end
      end
      super
    end

    def application_setting_params
      params.require(:application_setting).permit(
        extended_parameters,
        :name,
        :value,
        :description,
        :deletable,
        :mokio_application_settings_group_id
      )
    end

  end
end
