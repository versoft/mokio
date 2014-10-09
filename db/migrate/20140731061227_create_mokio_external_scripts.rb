class CreateMokioExternalScripts < ActiveRecord::Migration
  def change
    create_table :mokio_external_scripts do |t|
      t.string "name"
      t.text "script"
      t.boolean "editable",default: true
      t.boolean "deletable",default: true
    end
  end
end
