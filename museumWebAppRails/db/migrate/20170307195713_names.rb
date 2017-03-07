class Names < ActiveRecord::Migration[5.0]
  def change


  create_table "nodes", force: :cascade do |t|
    t.integer  "node_id",      null: false
    t.text     "name"
    t.integer  "voltage"
    t.datetime "last_reading"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "readings", force: :cascade do |t|
    t.integer  "node_id",     null: false
    t.text     "name"
    t.integer  "temperature", null: false
    t.integer  "humidity",    null: false
    t.datetime "recorded_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.integer  "pin",        null: false
    t.integer  "node_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end
  	
  end
end
