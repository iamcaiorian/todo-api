ActiveRecord::Schema[8.0].define(version: 2025_05_07_190129) do

  enable_extension "pg_catalog.plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "deadline"
    t.boolean "done"
    t.integer "priority"
    t.bigint "todolist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todolist_id"], name: "index_tasks_on_todolist_id"
  end

  create_table "todolists", force: :cascade do |t|
    t.string "title"
    t.string "subtitle"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tasks", "todolists"
end