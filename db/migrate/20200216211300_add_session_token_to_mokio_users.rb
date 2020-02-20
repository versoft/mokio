class AddSessionTokenToMokioUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :mokio_users, :session_token, :string
  end
end
