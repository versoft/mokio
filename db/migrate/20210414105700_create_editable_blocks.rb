class CreateEditableBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :mokio_editable_blocks do |t|
      t.string :hash_id, index: true
      t.string :lang
      t.text :content
      t.references :author, index: true, foreign_key: { to_table: :mokio_users }, type: :integer
      t.references :editor, index: true, foreign_key: { to_table: :mokio_users }, type: :integer
      t.text :location
      t.timestamps
    end
  end
end
