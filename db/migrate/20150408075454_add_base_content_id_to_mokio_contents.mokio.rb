# This migration comes from mokio (originally 20150408075347)
class AddBaseContentIdToMokioContents < ActiveRecord::Migration
  def change
    add_column :mokio_contents, :base_content_id, :int
  end
end
