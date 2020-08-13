class AddSlugToMokioContents < ActiveRecord::Migration[6.0]
  def change
    add_column :mokio_contents, :slug, :string
  end
end
