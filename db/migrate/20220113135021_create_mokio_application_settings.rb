class CreateMokioApplicationSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :mokio_application_settings do |t|
      t.string :name
      t.text :value
      t.boolean :deletable, default: true
      t.text :description
      t.string :field_type
      t.boolean :editable_name, default: true
      t.references :mokio_application_settings_group, index: {name: :mokio_app_setting_group}
      t.timestamps
    end

    # add_reference :mokio_application_settings, :mokio_application_settings_groups, index: true

  end
end
