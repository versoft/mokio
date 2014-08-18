class CreateMokioExternalCodes < ActiveRecord::Migration
  def change
    create_table :mokio_external_codes do |t|
      t.text "code"
      t.string "name"
      t.boolean "editable",default: true
      t.boolean "deletable",default: true
    end
  end
end
