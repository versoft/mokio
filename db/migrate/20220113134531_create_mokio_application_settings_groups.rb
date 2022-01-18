class CreateMokioApplicationSettingsGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :mokio_application_settings_groups do |t|
      t.string :name
    end
  end
end
