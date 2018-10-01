class AddBaseContentIdToMokioDataFiles < ActiveRecord::Migration[5.0]
  def change
    add_column :mokio_data_files, :base_content_id,:integer
  end
end
