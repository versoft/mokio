class CreateStaticPages < ActiveRecord::Migration[6.0]
  def change
    create_table :mokio_static_pages do |t|
      t.string :pathname
      t.string :path
      t.string :system_name
      t.datetime :sitemap_date
      t.boolean :automatic_date_update
      t.datetime :deleted_at
      t.text :custom_field_1
      t.text :custom_field_2
      t.text :custom_field_3
      t.text :custom_field_4
      t.text :custom_field_5
      t.timestamps
    end

    add_reference :mokio_static_pages, :lang, references: :mokio_langs, index: true
    add_reference :mokio_static_pages, :author, references: :mokio_users, index: true
    add_reference :mokio_static_pages, :editor, references: :mokio_users, index: true
  end
end
