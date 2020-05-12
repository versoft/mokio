class AddIndexToLangShortname < ActiveRecord::Migration[6.0]
  def change
    add_index "mokio_langs", ["shortname"], name: "index_mokio_langs_on_shortname", unique: true, using: :btree
  end
end
