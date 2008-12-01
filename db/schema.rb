# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080806193547) do

  create_table "bdrb_job_queues", :force => true do |t|
    t.binary   "args"
    t.string   "worker_name"
    t.string   "worker_method"
    t.string   "job_key"
    t.integer  "taken",          :limit => 11
    t.integer  "finished",       :limit => 11
    t.integer  "timeout",        :limit => 11
    t.integer  "priority",       :limit => 11
    t.datetime "submitted_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "archived_at"
    t.string   "tag"
    t.string   "submitter_info"
    t.string   "runner_info"
    t.string   "worker_key"
  end

  create_table "comments", :force => true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id",   :limit => 11
    t.integer  "user_id",          :limit => 11
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crawlers", :force => true do |t|
    t.string   "name"
    t.datetime "last_crawled_at"
    t.integer  "crawls_count",    :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_variants", :force => true do |t|
    t.integer  "cleared_id",       :limit => 11
    t.integer  "crawler_id",       :limit => 11
    t.string   "title"
    t.integer  "venue_variant_id", :limit => 11
    t.date     "date"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "end_date"
    t.time     "time"
    t.string   "url"
    t.text     "description"
    t.boolean  "review",                         :default => true
    t.string   "keywords"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.integer  "venue_id",    :limit => 11
    t.date     "date"
    t.time     "time"
    t.date     "end_date"
    t.time     "end_time"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "keywords"
  end

  create_table "localities", :force => true do |t|
    t.string   "name"
    t.string   "alternative_names"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locality_variants", :force => true do |t|
    t.string   "name"
    t.integer  "cleared_id", :limit => 11
    t.integer  "crawler_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.boolean  "review",                   :default => true
  end

  create_table "log_entries", :force => true do |t|
    t.string   "subject_type"
    t.integer  "subject_id",   :limit => 11
    t.string   "level"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

  create_table "venue_variants", :force => true do |t|
    t.integer  "cleared_id",          :limit => 11
    t.integer  "crawler_id",          :limit => 11
    t.string   "name"
    t.integer  "locality_variant_id", :limit => 11
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.boolean  "review",                            :default => true
    t.string   "keywords"
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "alternative_names"
    t.string   "locality_id"
    t.string   "address"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "keywords"
  end

  add_index "venues", ["name", "address"], :name => "name"

end
