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

ActiveRecord::Schema.define(version: 20171101205428) do

  create_table "clients", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.text "home_address"
    t.string "home_phone"
    t.string "cell_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "description"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "post_applications", force: :cascade do |t|
    t.integer "post_id"
    t.integer "teenager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message"
    t.string "status"
    t.index ["post_id"], name: "index_post_applications_on_post_id"
    t.index ["teenager_id"], name: "index_post_applications_on_teenager_id"
  end

  create_table "post_invitations", force: :cascade do |t|
    t.integer "post_id"
    t.integer "teenager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message"
    t.index ["post_id"], name: "index_post_invitations_on_post_id"
    t.index ["teenager_id"], name: "index_post_invitations_on_teenager_id"
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
    t.integer "post_status"
    t.integer "service_id"
    t.integer "service_category_id"
    t.integer "service_type_id"
    t.index ["client_id"], name: "index_posts_on_client_id"
    t.index ["service_id"], name: "index_posts_on_service_id"
  end

  create_table "service_categories", force: :cascade do |t|
    t.string "title"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_types", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "service_category_id"
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

  create_table "teenager_interests", force: :cascade do |t|
    t.integer "teenager_id"
    t.integer "service_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teenagers", force: :cascade do |t|
    t.text "email_address"
    t.text "home_address"
    t.string "cell_phone"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fname"
    t.string "lname"
    t.string "postal_code"
    t.integer "user_id"
    t.index ["user_id"], name: "index_teenagers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
