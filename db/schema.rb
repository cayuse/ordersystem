# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131213202929) do

  create_table "allergens", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort"
  end

  create_table "bidnames", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "addr1"
    t.string   "addr2"
    t.string   "city"
    t.string   "st"
    t.integer  "zip"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "fax"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companybidnames", :force => true do |t|
    t.integer  "company_id"
    t.integer  "bidname_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foodvendors", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "contact"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goldberg_content_pages", :force => true do |t|
    t.string   "title"
    t.string   "name",            :null => false
    t.integer  "markup_style_id"
    t.text     "content"
    t.integer  "permission_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content_cache"
    t.string   "markup_style"
  end

  add_index "goldberg_content_pages", ["markup_style_id"], :name => "fk_content_page_markup_style_id"
  add_index "goldberg_content_pages", ["permission_id"], :name => "fk_content_page_permission_id"

  create_table "goldberg_controller_actions", :force => true do |t|
    t.integer "site_controller_id", :null => false
    t.string  "name",               :null => false
    t.integer "permission_id"
    t.string  "url_to_use"
  end

  add_index "goldberg_controller_actions", ["permission_id"], :name => "fk_controller_action_permission_id"
  add_index "goldberg_controller_actions", ["site_controller_id"], :name => "fk_controller_action_site_controller_id"

  create_table "goldberg_menu_items", :force => true do |t|
    t.integer "parent_id"
    t.string  "name",                 :null => false
    t.string  "label",                :null => false
    t.integer "seq"
    t.integer "controller_action_id"
    t.integer "content_page_id"
  end

  add_index "goldberg_menu_items", ["content_page_id"], :name => "fk_menu_item_content_page_id"
  add_index "goldberg_menu_items", ["controller_action_id"], :name => "fk_menu_item_controller_action_id"
  add_index "goldberg_menu_items", ["parent_id"], :name => "fk_menu_item_parent_id"

  create_table "goldberg_permissions", :force => true do |t|
    t.string "name", :default => "", :null => false
  end

  create_table "goldberg_roles", :force => true do |t|
    t.string   "name",                            :null => false
    t.integer  "parent_id"
    t.string   "description",     :default => "", :null => false
    t.integer  "default_page_id"
    t.text     "cache"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "start_path"
  end

  add_index "goldberg_roles", ["default_page_id"], :name => "fk_role_default_page_id"
  add_index "goldberg_roles", ["parent_id"], :name => "fk_role_parent_id"

  create_table "goldberg_roles_permissions", :force => true do |t|
    t.integer "role_id",       :null => false
    t.integer "permission_id", :null => false
  end

  add_index "goldberg_roles_permissions", ["permission_id"], :name => "fk_roles_permission_permission_id"
  add_index "goldberg_roles_permissions", ["role_id"], :name => "fk_roles_permission_role_id"

  create_table "goldberg_site_controllers", :force => true do |t|
    t.string  "name",                         :null => false
    t.integer "permission_id",                :null => false
    t.integer "builtin",       :default => 0
  end

  add_index "goldberg_site_controllers", ["permission_id"], :name => "fk_site_controller_permission_id"

  create_table "goldberg_system_settings", :force => true do |t|
    t.string  "site_name",                                           :null => false
    t.string  "site_subtitle"
    t.string  "footer_message",                      :default => ""
    t.integer "public_role_id",                                      :null => false
    t.integer "session_timeout",                     :default => 0,  :null => false
    t.integer "site_default_page_id",                                :null => false
    t.integer "not_found_page_id",                                   :null => false
    t.integer "permission_denied_page_id",                           :null => false
    t.integer "session_expired_page_id",                             :null => false
    t.integer "menu_depth",                          :default => 0,  :null => false
    t.string  "start_path"
    t.string  "site_url_prefix"
    t.boolean "self_reg_enabled"
    t.integer "self_reg_role_id"
    t.boolean "self_reg_confirmation_required"
    t.integer "self_reg_confirmation_error_page_id"
    t.boolean "self_reg_send_confirmation_email"
  end

  add_index "goldberg_system_settings", ["not_found_page_id"], :name => "fk_system_settings_not_found_page_id"
  add_index "goldberg_system_settings", ["permission_denied_page_id"], :name => "fk_system_settings_permission_denied_page_id"
  add_index "goldberg_system_settings", ["public_role_id"], :name => "fk_system_settings_public_role_id"
  add_index "goldberg_system_settings", ["session_expired_page_id"], :name => "fk_system_settings_session_expired_page_id"
  add_index "goldberg_system_settings", ["site_default_page_id"], :name => "fk_system_settings_site_default_page_id"

  create_table "goldberg_users", :force => true do |t|
    t.string   "name",                           :null => false
    t.string   "password",                       :null => false
    t.integer  "role_id",                        :null => false
    t.string   "password_salt"
    t.string   "fullname"
    t.string   "email"
    t.string   "start_path"
    t.boolean  "self_reg_confirmation_required"
    t.string   "confirmation_key"
    t.datetime "password_changed_at"
    t.boolean  "password_expired"
  end

  add_index "goldberg_users", ["role_id"], :name => "fk_user_role_id"

  create_table "itemallergens", :force => true do |t|
    t.integer  "item_id"
    t.integer  "allergen_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "itemlocs", :force => true do |t|
    t.integer  "storeloc_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "units"
    t.string   "issue"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "itemtype_id"
    t.boolean  "mon"
    t.boolean  "tue"
    t.boolean  "wed"
    t.boolean  "thu"
    t.boolean  "fri"
  end

  create_table "itemtypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "colorcode"
  end

  create_table "itemtypes_usages", :id => false, :force => true do |t|
    t.integer  "itemtype_id"
    t.integer  "usage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthlyinvitems", :force => true do |t|
    t.integer  "monthlyinv_id"
    t.integer  "item_id"
    t.float    "qty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "storeloc_id"
    t.integer  "price_id"
  end

  create_table "monthlyinvreqs", :force => true do |t|
    t.integer  "sitetype_id"
    t.date     "month"
    t.date     "start"
    t.date     "due"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthlyinvs", :force => true do |t|
    t.integer  "monthlyinvreq_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthlysitems", :force => true do |t|
    t.integer  "site_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nutritionals", :force => true do |t|
    t.string   "category"
    t.string   "name"
    t.string   "codenum"
    t.text     "search"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "foodvendor_id"
    t.string   "mealequiv"
    t.string   "factor"
    t.string   "servings"
  end

  create_table "orderitems", :force => true do |t|
    t.integer  "weeklydfcorder_id"
    t.integer  "item_id"
    t.integer  "monqty"
    t.integer  "tueqty"
    t.integer  "wedqty"
    t.integer  "thuqty"
    t.integer  "friqty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "updated_by"
  end

  create_table "plugin_schema_migrations", :id => false, :force => true do |t|
    t.string "plugin_name", :null => false
    t.string "version",     :null => false
  end

  add_index "plugin_schema_migrations", ["plugin_name", "version"], :name => "unique_schema_migrations", :unique => true

  create_table "prices", :force => true do |t|
    t.integer  "item_id"
    t.date     "start"
    t.date     "expire"
    t.integer  "price_in_cents"
    t.integer  "cost_in_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fmv_in_cents"
  end

  create_table "settings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "site_id"
    t.integer  "track_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sitemizations", :force => true do |t|
    t.integer  "item_id"
    t.integer  "sitetype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.integer  "number"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state",       :limit => 2
    t.string   "zip",         :limit => 9
    t.string   "phone"
    t.integer  "user_id"
    t.integer  "sitetype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites_users", :id => false, :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sitetypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "mon"
    t.boolean  "tue"
    t.boolean  "wed"
    t.boolean  "thu"
    t.boolean  "fri"
  end

  create_table "storelocs", :force => true do |t|
    t.integer  "site_id"
    t.string   "name"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studentallergens", :force => true do |t|
    t.integer  "student_id"
    t.integer  "allergen_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.integer  "number"
    t.string   "name"
    t.string   "homeroom"
    t.integer  "grade"
    t.string   "track"
    t.boolean  "intersession"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "track_calendars", :force => true do |t|
    t.integer  "track_id"
    t.date     "start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weeklydfcorders", :force => true do |t|
    t.integer  "weeklyorderreq_id"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weeklyorderreqs", :force => true do |t|
    t.integer  "sitetype_id"
    t.date     "week"
    t.date     "due"
    t.boolean  "mon"
    t.boolean  "tue"
    t.boolean  "wed"
    t.boolean  "thu"
    t.boolean  "fri"
    t.boolean  "finalized"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worksheets", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "sheet_file_name"
    t.string   "sheet_content_type"
    t.integer  "sheet_file_size"
    t.datetime "sheet_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
