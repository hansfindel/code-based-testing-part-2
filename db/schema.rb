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

ActiveRecord::Schema.define(version: 20141004061951) do

  create_table "code_names", force: true do |t|
    t.string   "name"
    t.string   "info_reference"
    t.integer  "damage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "code_names", ["name"], name: "index_code_names_on_name"

  create_table "healths", force: true do |t|
    t.integer  "current"
    t.integer  "maximum"
    t.integer  "machine_id"
    t.string   "machine_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "healths", ["machine_id"], name: "index_healths_on_machine_id"
  add_index "healths", ["machine_type"], name: "index_healths_on_machine_type"

  create_table "robot_weapons", force: true do |t|
    t.integer  "robot_id"
    t.integer  "weapon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "robot_weapons", ["robot_id"], name: "index_robot_weapons_on_robot_id"
  add_index "robot_weapons", ["weapon_id"], name: "index_robot_weapons_on_weapon_id"

  create_table "robots", force: true do |t|
    t.integer  "code_name_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "robots", ["code_name_id"], name: "index_robots_on_code_name_id"

  create_table "weapons", force: true do |t|
    t.string   "name"
    t.integer  "damage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_freeze", default: false
  end

end
