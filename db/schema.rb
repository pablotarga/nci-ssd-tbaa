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

ActiveRecord::Schema.define(version: 2020_05_18_223839) do

  create_table "projects", force: :cascade do |t|
    t.integer "advisor_id"
    t.integer "student_id"
    t.integer "status", default: 0, null: false
    t.decimal "completion_rate", default: "0.0", null: false
    t.date "due_at"
    t.string "title"
    t.text "description"
    t.text "short_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_id"], name: "index_projects_on_advisor_id"
    t.index ["due_at"], name: "index_projects_on_due_at"
    t.index ["status"], name: "index_projects_on_status"
    t.index ["student_id"], name: "index_projects_on_student_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "project_id"
    t.string "title", null: false
    t.integer "priority", default: 2, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "due_at"
    t.index ["priority"], name: "index_tasks_on_priority"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["status"], name: "index_tasks_on_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "last_access_at"
    t.string "last_access_ip"
    t.datetime "current_access_at"
    t.string "current_access_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
  end

end
