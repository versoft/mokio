class AddAuthorAndEditorToMokioContent < ActiveRecord::Migration[5.0]
  def change
    add_column :mokio_contents, :created_by, :integer, after: :created_at
    add_column :mokio_contents, :updated_by, :integer, after: :updated_at
  end
end
