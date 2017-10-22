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

ActiveRecord::Schema.define(version: 20171022160546) do

  create_table "clients", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.text "home_address"
    t.string "home_phone"
    t.string "cell_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_applications", force: :cascade do |t|
    t.integer "post_id"
    t.integer "teenager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_job_applications_on_post_id"
    t.index ["teenager_id"], name: "index_job_applications_on_teenager_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "title"
    t.integer "client_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "work_address"
    t.string "pay"
    t.integer "number_of_teenager_needed"
    t.index ["client_id"], name: "index_posts_on_client_id"
  end

  create_table "services", force: :cascade do |t|
    t.integer "client_id"
    t.integer "teenager_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_services_on_client_id"
    t.index ["post_id"], name: "index_services_on_post_id"
    t.index ["teenager_id"], name: "index_services_on_teenager_id"
  end

  create_table "teenagers", force: :cascade do |t|
    t.text "email_address"
    t.text "home_address"
    t.string "home_phone"
    t.string "cell_phone"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fname"
    t.string "lname"
    t.integer "age"
  end

end
