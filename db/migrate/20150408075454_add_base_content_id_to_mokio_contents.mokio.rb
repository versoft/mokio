# This migration comes from mokio (originally 20150408075347)
class AddBaseContentIdToMokioContents < ActiveRecord::Migration[5.0]
  def change
    add_column :mokio_contents, :base_content_id, :int
  end
end
