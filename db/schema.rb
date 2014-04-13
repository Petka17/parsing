# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140409151024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "url_path"
    t.integer  "child_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",    default: 0, null: false
    t.integer  "attempts",    default: 0, null: false
    t.text     "handler",                 null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.integer  "progess",     default: 0
    t.string   "status"
    t.string   "status_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "features", force: true do |t|
    t.text     "name"
    t.text     "value"
    t.integer  "product_group_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "features", ["name"], name: "index_features_on_name", using: :btree
  add_index "features", ["product_group_id"], name: "index_features_on_product_group_id", using: :btree

  create_table "product_groups", force: true do |t|
    t.string   "name"
    t.string   "url_path"
    t.integer  "child_num"
    t.text     "description"
    t.integer  "subcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img_url"
  end

  add_index "product_groups", ["subcategory_id"], name: "index_product_groups_on_subcategory_id", using: :btree
  add_index "product_groups", ["url_path"], name: "index_product_groups_on_url_path", using: :btree

  create_table "products", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.float    "price"
    t.integer  "product_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "params"
  end

  add_index "products", ["code"], name: "index_products_on_code", using: :btree
  add_index "products", ["price"], name: "index_products_on_price", using: :btree
  add_index "products", ["product_group_id"], name: "index_products_on_product_group_id", using: :btree

  create_table "subcategories", force: true do |t|
    t.string   "name"
    t.string   "url_path"
    t.integer  "child_num"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree
  add_index "subcategories", ["name"], name: "index_subcategories_on_name", using: :btree

end
