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

ActiveRecord::Schema.define(version: 20141020232915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer "question_id"
    t.string  "content"
    t.boolean "correct"
    t.integer "student_id"
    t.integer "sitting_id"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["sitting_id"], name: "index_answers_on_sitting_id", using: :btree
  add_index "answers", ["student_id"], name: "index_answers_on_student_id", using: :btree

  create_table "enrollments", force: true do |t|
    t.integer "section_id"
    t.integer "student_id"
  end

  add_index "enrollments", ["section_id"], name: "index_enrollments_on_section_id", using: :btree
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id", using: :btree

  create_table "options", force: true do |t|
    t.integer "question_id"
    t.string  "content"
    t.boolean "correct?"
  end

  add_index "options", ["question_id"], name: "index_options_on_question_id", using: :btree

  create_table "questions", force: true do |t|
    t.integer "quiz_id"
    t.text    "query"
    t.string  "question_type", default: "multiple_choice"
  end

  add_index "questions", ["quiz_id"], name: "index_questions_on_quiz_id", using: :btree

  create_table "quizzes", force: true do |t|
    t.integer "requirement_id"
    t.string  "name"
    t.text    "instructions"
    t.integer "section_id"
  end

  add_index "quizzes", ["requirement_id"], name: "index_quizzes_on_requirement_id", using: :btree
  add_index "quizzes", ["section_id"], name: "index_quizzes_on_section_id", using: :btree

  create_table "requirements", force: true do |t|
    t.integer  "standard_id"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requirements", ["section_id"], name: "index_requirements_on_section_id", using: :btree
  add_index "requirements", ["standard_id", "section_id"], name: "index_requirements_on_standard_id_and_section_id", using: :btree

  create_table "sections", force: true do |t|
    t.string   "name"
    t.integer  "teacher_id"
    t.string   "subject"
    t.string   "grade"
    t.string   "passcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["passcode"], name: "index_sections_on_passcode", using: :btree
  add_index "sections", ["teacher_id"], name: "index_sections_on_teacher_id", using: :btree

  create_table "sittings", force: true do |t|
    t.integer "student_id"
    t.integer "quiz_id"
    t.integer "possible"
    t.integer "correct"
    t.boolean "graded"
  end

  add_index "sittings", ["quiz_id", "student_id"], name: "index_sittings_on_quiz_id_and_student_id", using: :btree
  add_index "sittings", ["student_id"], name: "index_sittings_on_student_id", using: :btree

  create_table "standards", force: true do |t|
    t.string "subject"
    t.string "grade"
    t.string "code"
    t.text   "description"
  end

  add_index "standards", ["grade"], name: "index_standards_on_grade", using: :btree
  add_index "standards", ["subject", "grade"], name: "index_standards_on_subject_and_grade", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
