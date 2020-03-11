class AddImageableToDataFiles < ActiveRecord::Migration[6.0]
  def change
    add_reference :mokio_data_files, :imageable, polymorphic: true
    remove_column :mokio_data_files, :content_id, :integer
  end
end
