class CreateMokioBaseContents < ActiveRecord::Migration
  def change
    create_table :mokio_base_contents do |t|
      t.string   "title"
      t.string   "type"
      t.boolean  "home_page"
      t.boolean  "active",       default: true
      t.boolean  "editable",     default: true
      t.boolean  "deletable",    default: true
      t.date     "display_from"
      t.date     "display_to"
      t.string   "main_pic"
      t.string   "etag"
      t.timestamps
    end
  end
end
