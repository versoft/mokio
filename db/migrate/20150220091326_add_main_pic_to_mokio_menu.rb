class AddMainPicToMokioMenu < ActiveRecord::Migration
  def change
    add_column :mokio_menus, :main_pic, :string
  end
end
