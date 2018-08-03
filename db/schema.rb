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

ActiveRecord::Schema.define(version: 2018_08_03_022529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "education_experiences", id: :serial, force: :cascade do |t|
    t.string "school_name"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "diploma"
    t.index ["user_id"], name: "index_education_experiences_on_user_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "oauth_access_grants", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :serial, force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "owner_type", null: false
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confidential", default: true, null: false
    t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "post_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_post_categories_on_user_id"
  end

  create_table "post_category_joinings", id: :serial, force: :cascade do |t|
    t.integer "post_id"
    t.integer "post_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_category_id"], name: "index_post_category_joinings_on_post_category_id"
    t.index ["post_id"], name: "index_post_category_joinings_on_post_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "published"
    t.integer "user_id"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_on"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "project_categories", id: :serial, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["user_id"], name: "index_project_categories_on_user_id"
  end

  create_table "project_category_joinings", id: :serial, force: :cascade do |t|
    t.integer "project_id"
    t.integer "project_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_category_id"], name: "index_project_category_joinings_on_project_category_id"
    t.index ["project_id"], name: "index_project_category_joinings_on_project_id"
  end

  create_table "project_statuses", id: :serial, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["user_id"], name: "index_project_statuses_on_user_id"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "short_description"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "project_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "github_url"
    t.string "vimeo_url"
    t.string "soundcloud_url"
    t.string "bandcamp_url"
    t.string "penflip_url"
    t.string "youtube_url"
    t.string "slug"
    t.boolean "featured", default: false, null: false
    t.index ["name"], name: "index_projects_on_name", unique: true
    t.index ["project_status_id"], name: "index_projects_on_project_status_id"
    t.index ["slug", "user_id"], name: "index_projects_on_slug_and_user_id", unique: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "resume_education_experiences", id: :serial, force: :cascade do |t|
    t.integer "resume_id"
    t.integer "education_experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["education_experience_id"], name: "index_resume_education_experiences_on_education_experience_id"
    t.index ["resume_id"], name: "index_resume_education_experiences_on_resume_id"
  end

  create_table "resume_projects", id: :serial, force: :cascade do |t|
    t.integer "resume_id"
    t.integer "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["project_id"], name: "index_resume_projects_on_project_id"
    t.index ["resume_id"], name: "index_resume_projects_on_resume_id"
  end

  create_table "resume_skills", id: :serial, force: :cascade do |t|
    t.integer "resume_id"
    t.integer "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["resume_id"], name: "index_resume_skills_on_resume_id"
    t.index ["skill_id"], name: "index_resume_skills_on_skill_id"
  end

  create_table "resume_work_experiences", id: :serial, force: :cascade do |t|
    t.integer "resume_id"
    t.integer "work_experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["resume_id"], name: "index_resume_work_experiences_on_resume_id"
    t.index ["work_experience_id"], name: "index_resume_work_experiences_on_work_experience_id"
  end

  create_table "resumes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.text "background"
    t.boolean "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "description"
    t.string "slug"
    t.index ["slug", "user_id"], name: "index_resumes_on_slug_and_user_id", unique: true
    t.index ["user_id"], name: "index_resumes_on_user_id"
  end

  create_table "skill_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.index ["user_id"], name: "index_skill_categories_on_user_id"
  end

  create_table "skills", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "skill_category_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_skills_on_name", unique: true
    t.index ["skill_category_id"], name: "index_skills_on_skill_category_id"
    t.index ["user_id"], name: "index_skills_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "first_name"
    t.string "last_name"
    t.text "about_me"
    t.string "tagline"
    t.string "github_handle"
    t.string "googleplus_handle"
    t.string "linkedin_handle"
    t.string "twitter_handle"
    t.string "subdomain"
    t.string "domain"
    t.string "avatar_label"
    t.string "tumblr_url"
    t.string "header_image"
    t.string "avatar_image"
    t.boolean "avatar_image_processing", default: false, null: false
    t.boolean "admin", default: false
    t.string "ga_property_id"
    t.string "ga_view_id"
    t.string "medium_handle"
    t.index ["domain"], name: "index_users_on_domain", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["subdomain"], name: "index_users_on_subdomain", unique: true
  end

  create_table "work_experiences", id: :serial, force: :cascade do |t|
    t.string "organization"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "position"
    t.index ["user_id"], name: "index_work_experiences_on_user_id"
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "post_categories", "users"
  add_foreign_key "post_category_joinings", "post_categories"
  add_foreign_key "post_category_joinings", "posts"
  add_foreign_key "posts", "users"
  add_foreign_key "project_categories", "users"
  add_foreign_key "project_statuses", "users"
  add_foreign_key "skill_categories", "users"
end
