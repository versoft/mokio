class CreateMokioExternalCodes < ActiveRecord::Migration
  def change
    create_table :mokio_external_scripts do |t|
      t.text "code"
      t.string "script"
      t.boolean "editable",default: true
      t.boolean "deletable",default: true
    end
  end
end
