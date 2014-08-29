class DropMokioExternalCodes < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? :mokio_external_codes
    drop_table :mokio_external_codes
    end
  end
end
