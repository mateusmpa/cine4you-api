# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_231_128_152_006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'catalogs', force: :cascade do |t|
    t.string 'title'
    t.bigint 'category_id', null: false
    t.bigint 'genre_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_catalogs_on_category_id'
    t.index ['genre_id'], name: 'index_catalogs_on_genre_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'kind'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'genres', force: :cascade do |t|
    t.string 'kind'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'rating'
    t.text 'comment'
    t.bigint 'catalog_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.index ['catalog_id'], name: 'index_reviews_on_catalog_id'
  end

  add_foreign_key 'catalogs', 'categories'
  add_foreign_key 'catalogs', 'genres'
  add_foreign_key 'reviews', 'catalogs'
end
