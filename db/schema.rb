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

ActiveRecord::Schema.define(version: 2023_10_21_025840) do

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

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.string "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "address"
    t.boolean "is_deleted", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "introduction"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "entries", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_entries_on_customer_id"
    t.index ["room_id"], name: "index_entries_on_room_id"
  end

  create_table "foster_parent_comments", force: :cascade do |t|
    t.text "comment"
    t.integer "customer_id"
    t.integer "foster_parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foster_parent_favorites", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "foster_parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foster_parent_hashtags", force: :cascade do |t|
    t.string "hashname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foster_parents", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "title", null: false
    t.string "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fp_hashtag_relations", force: :cascade do |t|
    t.integer "foster_parent_id"
    t.integer "foster_parent_hashtag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["foster_parent_hashtag_id"], name: "index_fp_hashtag_relations_on_foster_parent_hashtag_id"
    t.index ["foster_parent_id"], name: "index_fp_hashtag_relations_on_foster_parent_id"
  end

  create_table "galleries", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "title", null: false
    t.string "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "gallery_comments", force: :cascade do |t|
    t.text "comment"
    t.integer "customer_id"
    t.integer "gallery_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "gallery_favorites", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "gallery_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "gallery_hashtag_relations", force: :cascade do |t|
    t.integer "gallery_id"
    t.integer "gallery_hashtag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gallery_hashtag_id"], name: "index_gallery_hashtag_relations_on_gallery_hashtag_id"
    t.index ["gallery_id"], name: "index_gallery_hashtag_relations_on_gallery_id"
  end

  create_table "gallery_hashtags", force: :cascade do |t|
    t.string "hashname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "group_customers", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_group_customers_on_customer_id"
    t.index ["group_id"], name: "index_group_customers_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.text "introduction"
    t.string "image_id"
    t.integer "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hospital_genre_relations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "genre_id"
    t.integer "hospital_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number", null: false
    t.string "explanation", null: false
    t.string "address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lost_pet_comments", force: :cascade do |t|
    t.text "comment"
    t.integer "customer_id"
    t.integer "lost_pet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lost_pet_favorites", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "lost_pet_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lost_pet_hashtag_relations", force: :cascade do |t|
    t.integer "lost_pet_id"
    t.integer "lost_pet_hashtag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lost_pet_hashtag_id"], name: "index_lost_pet_hashtag_relations_on_lost_pet_hashtag_id"
    t.index ["lost_pet_id"], name: "index_lost_pet_hashtag_relations_on_lost_pet_id"
  end

  create_table "lost_pet_hashtags", force: :cascade do |t|
    t.string "hashname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lost_pets", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "title", null: false
    t.string "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "room_id", null: false
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_messages_on_customer_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_rooms_on_customer_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "entries", "customers"
  add_foreign_key "entries", "rooms"
  add_foreign_key "fp_hashtag_relations", "foster_parent_hashtags"
  add_foreign_key "fp_hashtag_relations", "foster_parents"
  add_foreign_key "gallery_hashtag_relations", "galleries"
  add_foreign_key "gallery_hashtag_relations", "gallery_hashtags"
  add_foreign_key "group_customers", "customers"
  add_foreign_key "group_customers", "groups"
  add_foreign_key "lost_pet_hashtag_relations", "lost_pet_hashtags"
  add_foreign_key "lost_pet_hashtag_relations", "lost_pets"
  add_foreign_key "messages", "customers"
  add_foreign_key "messages", "rooms"
  add_foreign_key "rooms", "customers"
end
