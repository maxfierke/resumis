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

ActiveRecord::Schema.define(version: 20141206235159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "education_experiences", force: true do |t|
    t.string   "school_name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "diploma"
  end

  add_index "education_experiences", ["user_id"], name: "index_education_experiences_on_user_id", using: :btree

  create_table "project_categories", force: true do |t|
    t.string   "slug"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_categories", ["name"], name: "index_project_categories_on_name", unique: true, using: :btree
  add_index "project_categories", ["slug"], name: "index_project_categories_on_slug", unique: true, using: :btree

  create_table "project_category_joinings", force: true do |t|
    t.integer  "project_id"
    t.integer  "project_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_category_joinings", ["project_category_id"], name: "index_project_category_joinings_on_project_category_id", using: :btree
  add_index "project_category_joinings", ["project_id"], name: "index_project_category_joinings_on_project_id", using: :btree

  create_table "project_statuses", force: true do |t|
    t.string   "slug"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_statuses", ["name"], name: "index_project_statuses_on_name", unique: true, using: :btree
  add_index "project_statuses", ["slug"], name: "index_project_statuses_on_slug", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "short_description"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "project_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "github_url"
  end

  add_index "projects", ["name"], name: "index_projects_on_name", unique: true, using: :btree
  add_index "projects", ["project_status_id"], name: "index_projects_on_project_status_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "resume_education_experiences", force: true do |t|
    t.integer  "resume_id"
    t.integer  "education_experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_education_experiences", ["education_experience_id"], name: "index_resume_education_experiences_on_education_experience_id", using: :btree
  add_index "resume_education_experiences", ["resume_id"], name: "index_resume_education_experiences_on_resume_id", using: :btree

  create_table "resume_projects", force: true do |t|
    t.integer  "resume_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_projects", ["project_id"], name: "index_resume_projects_on_project_id", using: :btree
  add_index "resume_projects", ["resume_id"], name: "index_resume_projects_on_resume_id", using: :btree

  create_table "resume_skills", force: true do |t|
    t.integer  "resume_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_skills", ["resume_id"], name: "index_resume_skills_on_resume_id", using: :btree
  add_index "resume_skills", ["skill_id"], name: "index_resume_skills_on_skill_id", using: :btree

  create_table "resume_work_experiences", force: true do |t|
    t.integer  "resume_id"
    t.integer  "work_experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resume_work_experiences", ["resume_id"], name: "index_resume_work_experiences_on_resume_id", using: :btree
  add_index "resume_work_experiences", ["work_experience_id"], name: "index_resume_work_experiences_on_work_experience_id", using: :btree

  create_table "resumes", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "background"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "resumes", ["user_id"], name: "index_resumes_on_user_id", using: :btree

  create_table "skill_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skill_categories", ["name"], name: "index_skill_categories_on_name", unique: true, using: :btree

  create_table "skills", force: true do |t|
    t.string   "name"
    t.integer  "skill_category_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["name"], name: "index_skills_on_name", unique: true, using: :btree
  add_index "skills", ["skill_category_id"], name: "index_skills_on_skill_category_id", using: :btree
  add_index "skills", ["user_id"], name: "index_skills_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "about_me"
    t.string   "tagline"
    t.string   "header_image_url"
    t.string   "github_handle"
    t.string   "googleplus_handle"
    t.string   "linkedin_handle"
    t.string   "twitter_handle"
    t.string   "subdomain"
    t.string   "domain"
  end

  add_index "users", ["domain"], name: "index_users_on_domain", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["subdomain"], name: "index_users_on_subdomain", unique: true, using: :btree

  create_table "work_experiences", force: true do |t|
    t.string   "organization"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "position"
  end

  add_index "work_experiences", ["user_id"], name: "index_work_experiences_on_user_id", using: :btree

end
