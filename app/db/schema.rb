# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_20_125503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "building_archives", force: :cascade do |t|
    t.bigint "people_id", null: false
    t.string "manager_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["people_id"], name: "index_building_archives_on_people_id"
  end

  create_table "buildings", force: :cascade do |t|
    t.string "reference"
    t.string "address"
    t.string "zip_code"
    t.string "city"
    t.string "country"
    t.string "manager_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reference"], name: "index_buildings_on_reference", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "reference"
    t.string "email"
    t.string "home_phone_number"
    t.string "mobile_phone_number"
    t.string "firstname"
    t.string "lastname"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reference"], name: "index_people_on_reference", unique: true
  end

  create_table "person_address_archives", force: :cascade do |t|
    t.bigint "person_id"
    t.string "address"
    t.index ["person_id", "address"], name: "index_person_archive_person_and_address", unique: true
    t.index ["person_id"], name: "index_person_address_archives_on_person_id"
  end

  create_table "person_email_archives", force: :cascade do |t|
    t.bigint "person_id"
    t.string "email"
    t.index ["person_id", "email"], name: "index_person_archive_person_and_email", unique: true
    t.index ["person_id"], name: "index_person_email_archives_on_person_id"
  end

  create_table "person_home_phone_number_archives", force: :cascade do |t|
    t.bigint "person_id"
    t.string "home_phone_number"
    t.index ["person_id", "home_phone_number"], name: "index_person_archive_person_and_home_phone_number", unique: true
    t.index ["person_id"], name: "index_person_home_phone_number_archives_on_person_id"
  end

  create_table "person_mobile_phone_number_archives", force: :cascade do |t|
    t.bigint "person_id"
    t.string "mobile_phone_number"
    t.index ["person_id", "mobile_phone_number"], name: "index_person_archive_person_and_mobile_phone_number", unique: true
    t.index ["person_id"], name: "index_person_mobile_phone_number_archives_on_person_id"
  end

  add_foreign_key "building_archives", "people", column: "people_id"
  add_foreign_key "person_address_archives", "people", on_delete: :cascade
  add_foreign_key "person_email_archives", "people", on_delete: :cascade
  add_foreign_key "person_home_phone_number_archives", "people", on_delete: :cascade
  add_foreign_key "person_mobile_phone_number_archives", "people", on_delete: :cascade
end
