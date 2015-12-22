class AddBaseContentIdToMokioDataFiles < ActiveRecord::Migration
  def change
    add_column :mokio_data_files, :base_content_id,:integer
  end
end
