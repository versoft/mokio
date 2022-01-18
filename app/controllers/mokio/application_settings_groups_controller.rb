class Mokio::ApplicationSettingsGroupsController < Mokio::CommonController

  def application_settings_group_params
    params.require(:application_settings_group).permit(extended_parameters, :name)
  end

end
