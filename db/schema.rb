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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140202050440) do

  create_table "crews", :force => true do |t|
    t.integer  "age"
    t.string   "name"
    t.string   "avatar"
    t.string   "title"
    t.string   "species"
    t.string   "origin"
    t.text     "quote"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "focus_areas", :force => true do |t|
    t.string   "title"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "notdos", :force => true do |t|
    t.string   "title"
    t.string   "project"
    t.string   "status"
    t.text     "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "priority"
  end

  add_index "notdos", ["project"], :name => "index_notdos_on_project"
  add_index "notdos", ["status"], :name => "index_notdos_on_status"

  create_table "procedures", :force => true do |t|
    t.string   "title"
    t.string   "category"
    t.text     "notes"
    t.integer  "focus_area_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "notes"
    t.integer  "focus_area_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  create_table "tickets", :force => true do |t|
    t.string   "title"
    t.text     "notes"
    t.string   "status"
    t.string   "priority"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
