class AddMainPicToMokioMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :mokio_menus, :main_pic, :string
  end
end
