class CreateMokioHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :mokio_histories do |t|
      t.text :before_value
      t.text :current_value
      t.string :field
      t.string :user_email
      t.references :historable, polymorphic: true, index: true
      t.datetime :changed_at
      t.timestamps
    end
  end
end
