class CreateMokioStructures < ActiveRecord::Migration[6.0]
  def change
    create_table :mokio_structures do |t|
      t.boolean :active
      t.references :structurable, polymorphic: true, index: true
      t.integer :parent_id
      t.timestamps
    end
  end
end
