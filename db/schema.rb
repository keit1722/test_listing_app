# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_19_041819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "organization_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_organization_users_on_organization_id"
    t.index ["user_id", "organization_id"], name: "index_organization_users_on_user_id_and_organization_id", unique: true
    t.index ["user_id"], name: "index_organization_users_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "phone", null: false
    t.string "slug", null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "restaurant_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["name"], name: "index_restaurant_categories_on_name", unique: true
  end

  create_table "restaurant_category_mappings", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.bigint "restaurant_category_id"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["restaurant_category_id"], name: "index_restaurant_category_mappings_on_restaurant_category_id"
    t.index ["restaurant_id", "restaurant_category_id"], name: "index_restaurant_category_mappings_on_id_and_category_id", unique: true
    t.index ["restaurant_id"], name: "index_restaurant_category_mappings_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.float "lat", null: false
    t.float "lng", null: false
    t.string "slug", null: false
    t.text "description", null: false
    t.bigint "organization_id"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["name"], name: "index_restaurants_on_name", unique: true
    t.index ["organization_id"], name: "index_restaurants_on_organization_id"
    t.index ["slug"], name: "index_restaurants_on_slug", unique: true
  end

  create_table "shops", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.float "lat", null: false
    t.float "lng", null: false
    t.string "slug", null: false
    t.text "description", null: false
    t.bigint "organization_id"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["name"], name: "index_shops_on_name", unique: true
    t.index ["organization_id"], name: "index_shops_on_organization_id"
    t.index ["slug"], name: "index_shops_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "role", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "public_uid"
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["public_uid"], name: "index_users_on_public_uid", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "organization_users", "organizations"
  add_foreign_key "organization_users", "users"
  add_foreign_key "restaurant_category_mappings", "restaurant_categories"
  add_foreign_key "restaurant_category_mappings", "restaurants"
  add_foreign_key "restaurants", "organizations"
  add_foreign_key "shops", "organizations"
end
