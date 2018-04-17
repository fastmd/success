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

ActiveRecord::Schema.define(version: 20180416185451) do

  create_table "cars", force: :cascade do |t|
    t.string   "marca"
    t.string   "gnum"
    t.string   "cuznum"
    t.string   "motnum"
    t.string   "proddate"
    t.string   "color"
    t.string   "vmot"
    t.string   "tmasa"
    t.string   "tsumm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "aprod"
    t.string   "capcil"
    t.integer  "int1"
    t.integer  "int1price"
    t.integer  "int2"
    t.integer  "int2price"
    t.integer  "int3"
    t.integer  "int3price"
    t.integer  "int4"
    t.integer  "int4price"
    t.integer  "int5"
    t.integer  "int5price"
    t.integer  "int6"
    t.integer  "int6price"
    t.integer  "int7"
    t.integer  "int7price"
    t.integer  "gaj"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "sname"
    t.string   "fname"
    t.string   "address"
    t.string   "pseria"
    t.string   "idno"
    t.string   "dn"
    t.string   "de"
    t.string   "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "bdate"
    t.string   "pemail"
    t.text     "comments"
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "cnum"
    t.datetime "order_date"
    t.integer  "car_id"
    t.integer  "client_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "diff"
    t.integer  "flag"
    t.string   "country"
    t.string   "summ"
    t.string   "zalog"
    t.datetime "enddate"
    t.datetime "fenddate"
    t.string   "garant_summ"
    t.float    "costlei"
    t.datetime "stdate"
    t.integer  "user_id"
    t.integer  "dperiod"
    t.decimal  "price"
    t.decimal  "curs"
    t.integer  "place"
    t.integer  "client2_id"
  end

  add_index "contracts", ["car_id"], name: "index_contracts_on_car_id"
  add_index "contracts", ["client2_id"], name: "index_contracts_on_client2_id"
  add_index "contracts", ["client_id"], name: "index_contracts_on_client_id"
  add_index "contracts", ["user_id"], name: "index_contracts_on_user_id"

  create_table "cparams", force: :cascade do |t|
    t.float    "curs"
    t.time     "mdt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tehservices", force: :cascade do |t|
    t.integer  "stype"
    t.decimal  "sprice",     precision: 2
    t.datetime "sdate"
    t.integer  "car_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "comments"
    t.integer  "user_id"
  end

  add_index "tehservices", ["car_id"], name: "index_tehservices_on_car_id"
  add_index "tehservices", ["user_id"], name: "index_tehservices_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.string   "name"
    t.string   "surname"
    t.date     "bdate"
    t.boolean  "superadmin_role",        default: false
    t.boolean  "supervisor_role",        default: false
    t.boolean  "user_role",              default: false
    t.boolean  "nemo_role",              default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "wlongs", force: :cascade do |t|
    t.integer  "parcurs"
    t.datetime "wdate"
    t.integer  "car_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "contract_id"
    t.integer  "tehservice_id"
  end

  add_index "wlongs", ["car_id"], name: "index_wlongs_on_car_id"
  add_index "wlongs", ["contract_id"], name: "index_wlongs_on_contract_id"
  add_index "wlongs", ["tehservice_id"], name: "index_wlongs_on_tehservice_id"

end
