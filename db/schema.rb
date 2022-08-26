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

ActiveRecord::Schema[7.0].define(version: 2022_01_18_025450) do
  create_table "addresses", force: :cascade do |t|
    t.string "line_one"
    t.string "line_two"
    t.string "city"
    t.string "country"
    t.string "region"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "to_address_id"
    t.integer "from_address_id"
    t.string "state", default: "information_recieved", null: false
    t.index ["from_address_id"], name: "index_packages_on_from_address_id"
    t.index ["to_address_id"], name: "index_packages_on_to_address_id"
  end

  add_foreign_key "packages", "addresses", column: "from_address_id"
  add_foreign_key "packages", "addresses", column: "to_address_id"
end
