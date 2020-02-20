class AddLockableToMokioUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :mokio_users, :failed_attempts, :integer, default: 0, null: false
    add_column :mokio_users, :locked_at, :datetime
  end
end
