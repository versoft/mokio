class AddMokioToApplication < ActiveRecord::Migration[5.0]
  def change
    create_table "mokio_available_modules" do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "module_position_id"
      t.integer  "static_module_id"
    end

    add_index "mokio_available_modules", ["module_position_id"], name: "index_mokio_available_modules_on_module_position_id", using: :btree
    add_index "mokio_available_modules", ["static_module_id"], name: "index_mokio_available_modules_on_static_module_id", using: :btree

    create_table "ckeditor_assets" do |t|
      t.string   "data_file_name",               null: false
      t.string   "data_content_type"
      t.integer  "data_file_size"
      t.integer  "assetable_id"
      t.string   "assetable_type",    limit: 30
      t.string   "type",              limit: 30
      t.integer  "width"
      t.integer  "height"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree


    create_table "mokio_contact_templates" do |t|
      t.text     "tpl"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "contact_id"
    end

    add_index "mokio_contact_templates", ["contact_id"], name: "index_mokio_contact_templates_on_contact_id", using: :btree

    create_table "mokio_content_links" do |t|
      t.integer "content_id"
      t.integer "menu_id"
      t.integer "seq"
    end

    add_index "mokio_content_links", ["content_id", "menu_id"], name: "index_mokio_content_links_on_content_id_and_menu_id", unique: true, using: :btree

    create_table "mokio_contents" do |t|
      t.string   "title"
      t.text     "subtitle"
      t.text     "intro"
      t.text     "content"
      t.string   "type"
      t.boolean  "home_page"
      t.string   "tpl"
      t.boolean  "contact"
      t.boolean  "active",       default: true
      t.integer  "lang_id"
      t.string   "gallery_type"
      t.boolean  "editable",     default: true
      t.boolean  "deletable",    default: true
      t.datetime "display_from"
      t.datetime  "display_to"
      t.datetime "created_at"
      t.integer  "created_by"
      t.datetime "updated_at"
      t.integer  "updated_by"
      t.integer  "meta_id"
      t.integer  "gmap_id"
      t.string   "comment_type"
      t.datetime "etag"
      t.string   "main_pic"
    end

    add_index "mokio_contents", ["gmap_id"], name: "index_mokio_contents_on_gmap_id", using: :btree
    add_index "mokio_contents", ["meta_id"], name: "index_mokio_contents_on_meta_id", using: :btree

    create_table "mokio_data_files" do |t|
      t.string   "name"
      t.string   "data_file"
      t.integer  "download_count",     default: 0
      t.integer  "seq"
      t.string   "type"
      t.boolean  "active",             default: true
      t.string   "movie_url"
      t.string   "external_link"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "content_id"
      t.string   "thumb",              default: "0"
      t.text     "intro"
      t.string   "subtitle"
      t.string   "thumb_external_url"
      t.string   "slug"
    end

    add_index "mokio_data_files", ["content_id"], name: "index_mokio_data_files_on_content_id", using: :btree

    create_table "mokio_gmaps" do |t|
      t.string   "full_address"
      t.string   "street_number"
      t.string   "route"
      t.string   "locality"
      t.string   "postal_code"
      t.string   "country"
      t.string   "administrative_area_level_2"
      t.string   "administrative_area_level_1"
      t.string   "gtype"
      t.decimal  "lat",                                   precision: 10, scale: 6
      t.decimal  "lng",                                   precision: 10, scale: 6
      t.integer  "zoom",                        limit: 1,                          default: 15
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "mokio_gmaps", ["lat"], name: "index_mokio_gmaps_on_lat", using: :btree
    add_index "mokio_gmaps", ["lng"], name: "index_mokio_gmaps_on_lng", using: :btree

    create_table "mokio_langs" do |t|
      t.string   "name"
      t.string   "shortname"
      t.boolean  "active"
      t.integer  "menu_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "mokio_menus" do |t|
      t.string   "main_pic"
      t.string   "name"
      t.text     "subtitle"
      t.boolean  "active",           default: true
      t.integer  "seq"
      t.string   "target"
      t.string   "external_link"
      t.integer  "lang_id"
      t.boolean  "editable",         default: true
      t.boolean  "deletable",        default: true
      t.boolean  "visible",          default: true
      t.integer  "position_id"
      t.string   "ancestry"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "description"
      t.boolean  "content_editable", default: true
      t.boolean  "modules_editable", default: true
      t.boolean  "fake",             default: false
      t.integer  "meta_id"
      t.boolean  "follow"
      t.string   "slug"
      t.string   "css_class"
      t.string   "css_body_class"
    end

    add_index "mokio_menus", ["ancestry"], name: "index_mokio_menus_on_ancestry", using: :btree
    add_index "mokio_menus", ["meta_id"], name: "index_mokio_menus_on_meta_id", using: :btree
    add_index "mokio_menus", ["slug"], name: "index_mokio_menus_on_slug", unique: true, using: :btree

    create_table "mokio_meta" do |t|
      t.string   "g_title"
      t.string   "g_desc"
      t.string   "g_keywords"
      t.string   "g_author"
      t.string   "g_copyright"
      t.string   "g_application_name"
      t.string   "f_title"
      t.string   "f_type"
      t.string   "f_image"
      t.string   "f_url"
      t.string   "f_desc"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "mokio_module_positions" do |t|
      t.string   "name"
      t.string   "tpl"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "mokio_recipients" do |t|
      t.string   "email",                     null: false
      t.boolean  "active",     default: true
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "contact_id"
    end

    add_index "mokio_recipients", ["contact_id"], name: "index_mokio_recipients_on_contact_id", using: :btree

    create_table "mokio_selected_modules" do |t|
      t.integer  "available_module_id"
      t.integer  "menu_id"
      t.integer  "seq"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "mokio_static_modules" do |t|
      t.integer  "available_modules_id"
      t.string   "title"
      t.text     "subtitle"
      t.text     "content"
      t.string   "external_link"
      t.integer  "lang_id"
      t.boolean  "active",               default: true
      t.boolean  "editable",             default: true
      t.boolean  "deletable",            default: true
      t.boolean  "always_displayed"
      t.string   "tpl"
      t.datetime "display_from"
      t.datetime "display_to"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "intro"
    end

    create_table "mokio_users" do |t|
      t.string   "email",                  default: "", null: false
      t.string   "first_name"
      t.string   "last_name"
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "roles_mask"
    end

    add_index "mokio_users", ["email"], name: "index_mokio_users_on_email", unique: true, using: :btree
    add_index "mokio_users", ["reset_password_token"], name: "index_mokio_users_on_reset_password_token", unique: true, using: :btree

    create_table :mokio_external_scripts do |t|
      t.string "name"
      t.text "script"
      t.boolean "editable",default: true
      t.boolean "deletable",default: true
    end
  end
end
