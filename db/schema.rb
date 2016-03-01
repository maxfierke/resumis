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

ActiveRecord::Schema.define(version: 20160301023133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "education_experiences", force: :cascade do |t|
    t.string   "school_name", limit: 255
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "diploma",     limit: 255
  end

  add_index "education_experiences", ["user_id"], name: "index_education_experiences_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "post_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "post_categories", ["user_id"], name: "index_post_categories_on_user_id", using: :btree

  create_table "post_category_joinings", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "post_category_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "post_category_joinings", ["post_category_id"], name: "index_post_category_joinings_on_post_category_id", using: :btree
  add_index "post_category_joinings", ["post_id"], name: "index_post_category_joinings_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "published_on"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "project_categories", force: :cascade do |t|
    t.string   "slug",       limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "project_categories", ["user_id"], name: "index_project_categories_on_user_id", using: :btree

  create_table "project_category_joinings", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "project_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_category_joinings", ["project_category_id"], name: "index_project_category_joinings_on_project_category_id", using: :btree
  add_index "project_category_joinings", ["project_id"], name: "index_project_category_joinings_on_project_id", using: :btree

  create_table "project_statuses", force: :cascade do |t|
    t.string   "slug",       limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "project_statuses", ["user_id"], name: "index_project_statuses_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "short_description", limit: 255
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "project_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "github_url",        limit: 255
    t.string   "vimeo_url"
    t.string   "soundcloud_url"
    t.string   "bandcamp_url"
    t.string   "penflip_url"
    t.string   "youtube_url"
    t.string   "slug"
  end

  add_index "projects", ["name"], name: "index_projects_on_name", unique: true, using: :btree
  add_index "projects", ["project_status_id"], name: "index_projects_on_project_status_id", using: :btree
  add_index "projects", ["slug", "user_id"], name: "index_projects_on_slug_and_user_id", unique: true, using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "resume_education_experiences", force: :cascade do |t|
    t.integer  "resume_id"
    t.integer  "education_experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_education_experiences", ["education_experience_id"], name: "index_resume_education_experiences_on_education_experience_id", using: :btree
  add_index "resume_education_experiences", ["resume_id"], name: "index_resume_education_experiences_on_resume_id", using: :btree

  create_table "resume_projects", force: :cascade do |t|
    t.integer  "resume_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_projects", ["project_id"], name: "index_resume_projects_on_project_id", using: :btree
  add_index "resume_projects", ["resume_id"], name: "index_resume_projects_on_resume_id", using: :btree

  create_table "resume_skills", force: :cascade do |t|
    t.integer  "resume_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_skills", ["resume_id"], name: "index_resume_skills_on_resume_id", using: :btree
  add_index "resume_skills", ["skill_id"], name: "index_resume_skills_on_skill_id", using: :btree

  create_table "resume_work_experiences", force: :cascade do |t|
    t.integer  "resume_id"
    t.integer  "work_experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_work_experiences", ["resume_id"], name: "index_resume_work_experiences_on_resume_id", using: :btree
  add_index "resume_work_experiences", ["work_experience_id"], name: "index_resume_work_experiences_on_work_experience_id", using: :btree

  create_table "resumes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",        limit: 255
    t.text     "background"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description", limit: 255
    t.string   "slug"
  end

  add_index "resumes", ["slug", "user_id"], name: "index_resumes_on_slug_and_user_id", unique: true, using: :btree
  add_index "resumes", ["user_id"], name: "index_resumes_on_user_id", using: :btree

  create_table "skill_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "skill_categories", ["user_id"], name: "index_skill_categories_on_user_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "skill_category_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["name"], name: "index_skills_on_name", unique: true, using: :btree
  add_index "skills", ["skill_category_id"], name: "index_skills_on_skill_category_id", using: :btree
  add_index "skills", ["user_id"], name: "index_skills_on_user_id", using: :btree

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "types", ["slug"], name: "index_types_on_slug", unique: true, using: :btree

  create_table "user_types", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "type_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   limit: 255, default: "",    null: false
    t.string   "encrypted_password",      limit: 255, default: "",    null: false
    t.string   "reset_password_token",    limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.text     "about_me"
    t.string   "tagline",                 limit: 255
    t.string   "github_handle",           limit: 255
    t.string   "googleplus_handle",       limit: 255
    t.string   "linkedin_handle",         limit: 255
    t.string   "twitter_handle",          limit: 255
    t.string   "subdomain",               limit: 255
    t.string   "domain",                  limit: 255
    t.string   "avatar_label",            limit: 255
    t.string   "soundcloud_handle"
    t.string   "tumblr_url"
    t.string   "vimeo_handle"
    t.string   "youtube_handle"
    t.string   "header_image"
    t.integer  "header_media_type",                   default: 0
    t.string   "header_video"
    t.string   "avatar_image"
    t.boolean  "avatar_image_processing",             default: false, null: false
    t.boolean  "header_video_processing",             default: false, null: false
    t.boolean  "admin",                               default: false
    t.string   "ga_property_id"
    t.string   "ga_view_id"
    t.string   "medium_handle"
  end

  add_index "users", ["domain"], name: "index_users_on_domain", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["subdomain"], name: "index_users_on_subdomain", unique: true, using: :btree

  create_table "work_experiences", force: :cascade do |t|
    t.string   "organization", limit: 255
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "position",     limit: 255
  end

  add_index "work_experiences", ["user_id"], name: "index_work_experiences_on_user_id", using: :btree

  add_foreign_key "post_categories", "users"
  add_foreign_key "post_category_joinings", "post_categories"
  add_foreign_key "post_category_joinings", "posts"
  add_foreign_key "posts", "users"
  add_foreign_key "project_categories", "users"
  add_foreign_key "project_statuses", "users"
  add_foreign_key "skill_categories", "users"
end
