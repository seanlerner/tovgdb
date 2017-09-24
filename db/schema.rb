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

ActiveRecord::Schema.define(version: 20170924192806) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "role",                   limit: 255
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "communities", force: :cascade do |t|
    t.string   "name",                    limit: 255,              null: false
    t.string   "description",             limit: 255, default: "", null: false
    t.integer  "games_communities_count", limit: 4,   default: 0,  null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "communities", ["name"], name: "index_communities_on_name", unique: true, using: :btree

  create_table "creators", force: :cascade do |t|
    t.string   "name",                   limit: 255,               null: false
    t.text     "description",            limit: 65535,             null: false
    t.string   "logo_file_name",         limit: 255
    t.string   "logo_content_type",      limit: 255
    t.integer  "logo_file_size",         limit: 4
    t.datetime "logo_updated_at"
    t.integer  "games_creators_count",   limit: 4,     default: 0, null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.text     "old_raw_mediawiki_data", limit: 65535
    t.date     "founded_on"
    t.boolean  "published"
    t.string   "alternate_names",        limit: 255
  end

  add_index "creators", ["founded_on"], name: "index_creators_on_founded_on", using: :btree
  add_index "creators", ["name"], name: "index_creators_on_name", unique: true, using: :btree

  create_table "distribution_channels", force: :cascade do |t|
    t.string   "name",                              limit: 255
    t.string   "description",                       limit: 255, null: false
    t.string   "category",                          limit: 255
    t.integer  "games_distribution_channels_count", limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "distribution_channels", ["category"], name: "index_distribution_channels_on_category", using: :btree
  add_index "distribution_channels", ["name"], name: "index_distribution_channels_on_name", unique: true, using: :btree

  create_table "engines", force: :cascade do |t|
    t.string   "name",        limit: 255,             null: false
    t.string   "description", limit: 255,             null: false
    t.integer  "games_count", limit: 4,   default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "engines", ["name"], name: "index_engines_on_name", unique: true, using: :btree

  create_table "game_images", force: :cascade do |t|
    t.integer  "game_id",            limit: 4,     null: false
    t.string   "caption",            limit: 255,   null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.text     "image_meta",         limit: 65535
    t.integer  "order",              limit: 4
  end

  add_index "game_images", ["game_id"], name: "index_game_images_on_game_id", using: :btree
  add_index "game_images", ["order"], name: "index_game_images_on_order", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "name",                              limit: 255,                null: false
    t.string   "short_description",                 limit: 255,   default: "", null: false
    t.text     "long_description",                  limit: 65535,              null: false
    t.date     "published_on"
    t.integer  "games_creators_count",              limit: 4,     default: 0,  null: false
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "engine_id",                         limit: 4
    t.integer  "series_id",                         limit: 4
    t.date     "initial_release_on"
    t.integer  "games_platforms_count",             limit: 4,     default: 0,  null: false
    t.integer  "games_genres_count",                limit: 4,     default: 0,  null: false
    t.integer  "games_styles_count",                limit: 4,     default: 0,  null: false
    t.integer  "games_communities_count",           limit: 4,     default: 0,  null: false
    t.text     "old_raw_mediawiki_data",            limit: 65535
    t.boolean  "self_published"
    t.boolean  "digital_distribution"
    t.boolean  "retail_distribution"
    t.integer  "games_themes_count",                limit: 4,     default: 0,  null: false
    t.integer  "minimum_number_of_players",         limit: 4
    t.integer  "maximum_number_of_players",         limit: 4
    t.boolean  "local_play"
    t.boolean  "online_play"
    t.boolean  "coop_play"
    t.boolean  "competitive_play"
    t.boolean  "free"
    t.boolean  "freemium"
    t.boolean  "free_trial"
    t.boolean  "donation"
    t.boolean  "ads"
    t.boolean  "pay"
    t.boolean  "not_available"
    t.integer  "games_distribution_channels_count", limit: 4,     default: 0,  null: false
    t.boolean  "published"
    t.text     "sources",                           limit: 65535
    t.string   "alternate_names",                   limit: 255
    t.string   "publication_status",                limit: 255
    t.text     "submission_notes",                  limit: 65535
    t.string   "submitted_by_contact_info",         limit: 255
  end

  add_index "games", ["engine_id"], name: "index_games_on_engine_id", using: :btree
  add_index "games", ["initial_release_on"], name: "index_games_on_initial_release_on", using: :btree
  add_index "games", ["maximum_number_of_players"], name: "index_games_on_maximum_number_of_players", using: :btree
  add_index "games", ["minimum_number_of_players"], name: "index_games_on_minimum_number_of_players", using: :btree
  add_index "games", ["name"], name: "index_games_on_name", unique: true, using: :btree
  add_index "games", ["published_on"], name: "index_games_on_published_on", using: :btree
  add_index "games", ["series_id"], name: "index_games_on_series_id", using: :btree

  create_table "games_communities", force: :cascade do |t|
    t.integer "game_id",      limit: 4, null: false
    t.integer "community_id", limit: 4, null: false
  end

  add_index "games_communities", ["game_id", "community_id"], name: "index_games_communities_on_game_id_and_community_id", unique: true, using: :btree

  create_table "games_creators", force: :cascade do |t|
    t.integer "game_id",    limit: 4
    t.integer "creator_id", limit: 4
    t.boolean "developer"
    t.boolean "publisher"
  end

  add_index "games_creators", ["creator_id"], name: "index_games_creators_on_creator_id", using: :btree
  add_index "games_creators", ["game_id", "creator_id"], name: "index_games_creators_on_game_id_and_creator_id", unique: true, using: :btree
  add_index "games_creators", ["game_id"], name: "index_games_creators_on_game_id", using: :btree

  create_table "games_distribution_channels", force: :cascade do |t|
    t.integer  "game_id",                 limit: 4
    t.integer  "distribution_channel_id", limit: 4
    t.date     "released_on"
    t.text     "uri",                     limit: 65535, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "games_distribution_channels", ["game_id", "distribution_channel_id"], name: "index_games_dist_channels_on_game_id_and_dist_channel_id", unique: true, using: :btree
  add_index "games_distribution_channels", ["released_on"], name: "index_games_distribution_channels_on_released_on", using: :btree

  create_table "games_genres", force: :cascade do |t|
    t.integer "game_id",  limit: 4, null: false
    t.integer "genre_id", limit: 4, null: false
  end

  add_index "games_genres", ["game_id", "genre_id"], name: "index_games_genres_on_game_id_and_genre_id", unique: true, using: :btree

  create_table "games_platforms", force: :cascade do |t|
    t.integer "game_id",     limit: 4, null: false
    t.integer "platform_id", limit: 4, null: false
    t.date    "released_on"
  end

  add_index "games_platforms", ["game_id", "platform_id"], name: "index_games_platforms_on_game_id_and_platform_id", unique: true, using: :btree
  add_index "games_platforms", ["released_on"], name: "index_games_platforms_on_released_on", using: :btree

  create_table "games_styles", force: :cascade do |t|
    t.integer "game_id",  limit: 4, null: false
    t.integer "style_id", limit: 4, null: false
  end

  add_index "games_styles", ["game_id", "style_id"], name: "index_games_styles_on_game_id_and_style_id", unique: true, using: :btree

  create_table "games_themes", force: :cascade do |t|
    t.integer "game_id",  limit: 4, null: false
    t.integer "theme_id", limit: 4, null: false
  end

  add_index "games_themes", ["game_id", "theme_id"], name: "index_games_themes_on_game_id_and_theme_id", unique: true, using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "name",               limit: 255,              null: false
    t.string   "description",        limit: 255, default: "", null: false
    t.integer  "games_genres_count", limit: 4,   default: 0,  null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "genres", ["name"], name: "index_genres_on_name", unique: true, using: :btree

  create_table "link_types", force: :cascade do |t|
    t.string  "name",         limit: 255, null: false
    t.boolean "game_link"
    t.boolean "creator_link"
    t.string  "category",     limit: 255
  end

  add_index "link_types", ["creator_link"], name: "index_link_types_on_creator_link", using: :btree
  add_index "link_types", ["game_link"], name: "index_link_types_on_game_link", using: :btree
  add_index "link_types", ["name"], name: "index_link_types_on_name", unique: true, using: :btree

  create_table "links", force: :cascade do |t|
    t.integer "object_has_link_id",   limit: 4
    t.string  "object_has_link_type", limit: 255
    t.integer "link_type_id",         limit: 4,     null: false
    t.text    "uri",                  limit: 65535, null: false
    t.string  "description_override", limit: 255,   null: false
  end

  add_index "links", ["object_has_link_id", "link_type_id"], name: "index_links_on_object_has_link_id_and_link_type_id", using: :btree
  add_index "links", ["object_has_link_type", "object_has_link_id"], name: "index_links_on_object_has_link_type_and_object_has_link_id", using: :btree

  create_table "menu_items", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "uri",        limit: 255, null: false
    t.string   "menu",       limit: 255, null: false
    t.integer  "order",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "menu_items", ["menu", "order"], name: "index_menu_items_on_menu_and_order", using: :btree
  add_index "menu_items", ["name"], name: "index_menu_items_on_name", using: :btree
  add_index "menu_items", ["uri"], name: "index_menu_items_on_uri", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",      limit: 255,   null: false
    t.string   "slug",       limit: 255,   null: false
    t.text     "content",    limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree
  add_index "pages", ["title"], name: "index_pages_on_title", unique: true, using: :btree

  create_table "platforms", force: :cascade do |t|
    t.string   "name",                  limit: 255,             null: false
    t.string   "description",           limit: 255,             null: false
    t.integer  "games_platforms_count", limit: 4,   default: 0, null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "platforms", ["name"], name: "index_platforms_on_name", unique: true, using: :btree

  create_table "series", force: :cascade do |t|
    t.string   "name",        limit: 255,             null: false
    t.string   "description", limit: 255,             null: false
    t.integer  "games_count", limit: 4,   default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "series", ["name"], name: "index_series_on_name", unique: true, using: :btree

  create_table "styles", force: :cascade do |t|
    t.string   "name",               limit: 255,              null: false
    t.string   "description",        limit: 255, default: "", null: false
    t.integer  "games_styles_count", limit: 4,   default: 0,  null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "styles", ["name"], name: "index_styles_on_name", unique: true, using: :btree

  create_table "themes", force: :cascade do |t|
    t.string   "name",               limit: 255,              null: false
    t.string   "description",        limit: 255, default: "", null: false
    t.integer  "games_themes_count", limit: 4,   default: 0,  null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "themes", ["name"], name: "index_themes_on_name", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.integer  "game_id",    limit: 4
    t.string   "title",      limit: 255, null: false
    t.string   "platform",   limit: 255, null: false
    t.string   "code",       limit: 255, null: false
    t.string   "video_type", limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "videos", ["game_id"], name: "index_videos_on_game_id", using: :btree

  add_foreign_key "game_images", "games"
  add_foreign_key "games_creators", "creators", name: "fk_rails_sean_custom"
  add_foreign_key "games_creators", "games"
end
