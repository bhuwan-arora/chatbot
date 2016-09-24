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

ActiveRecord::Schema.define(version: 20160726065752) do

  create_table "active_learning_questions", force: :cascade do |t|
    t.integer  "index"
    t.text     "content"
    t.integer  "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapter_indices", force: :cascade do |t|
    t.integer  "chapter_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "element_count"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "chemical_connections", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chemical_reactions", force: :cascade do |t|
    t.integer  "image_id"
    t.text     "description"
    t.integer  "position"
    t.integer  "topic_id"
    t.integer  "chapter_id"
    t.integer  "sub_heading_id"
    t.integer  "example_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "examples", force: :cascade do |t|
    t.text     "content"
    t.integer  "topic_id"
    t.integer  "position"
    t.integer  "element_count"
    t.text     "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "for_reviews", force: :cascade do |t|
    t.text     "content"
    t.integer  "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.integer  "chapter_id"
    t.integer  "topic_id"
    t.integer  "table_id"
    t.integer  "chemical_reaction_id"
    t.integer  "sub_heading_id"
    t.integer  "example_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "keyterms", force: :cascade do |t|
    t.string   "name"
    t.integer  "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.string   "name"
    t.text     "url"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paragraphs", force: :cascade do |t|
    t.text     "content"
    t.integer  "position"
    t.integer  "chapter_id"
    t.integer  "topic_id"
    t.integer  "sub_heading_id"
    t.integer  "example_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "problem_solving_strategies", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.text     "content"
    t.string   "author"
    t.integer  "position"
    t.integer  "topic_id"
    t.integer  "chapter_id"
    t.integer  "sub_heading_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "sub_headings", force: :cascade do |t|
    t.string   "name"
    t.integer  "element_count"
    t.integer  "position"
    t.integer  "topic_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "tables", force: :cascade do |t|
    t.text     "content"
    t.integer  "position"
    t.integer  "topic_id"
    t.integer  "chapter_id"
    t.integer  "sub_heading_id"
    t.integer  "example_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "chapter_id"
    t.integer  "element_count"
    t.integer  "position"
    t.text     "name"
    t.boolean  "links_updated"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
