class ChangeDataTypeForDisplayDates < ActiveRecord::Migration
  def change
    change_table :mokio_contents do |t|
      t.change :display_from, :datetime
      t.change :display_to, :datetime
    end
  end
end
