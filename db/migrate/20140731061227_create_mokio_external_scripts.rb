class CreateMokioExternalScripts < ActiveRecord::Migration
  def change
    if !ActiveRecord::Base.connection.table_exists? :mokio_external_scripts
      create_table :mokio_external_scripts do |t|
        t.text "code"
        t.string "script"
        t.boolean "editable",default: true
        t.boolean "deletable",default: true
      end
    end
  end
end
