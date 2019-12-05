class CreateMokioSeoTags < ActiveRecord::Migration[5.2]
  def change
    create_table :mokio_seo_tags do |t|
      t.string :tag_key
      t.text :tag_value
      t.references :seo_tagable, polymorphic: true, index: true
      t.integer :seo_tagable_id
      t.timestamps
    end
  end
end
