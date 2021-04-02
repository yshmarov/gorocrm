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

ActiveRecord::Schema.define(version: 2021_04_02_202009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient"
    t.index ["tenant_id"], name: "index_activities_on_tenant_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable"
  end

  create_table "cash_accounts", force: :cascade do |t|
    t.string "name"
    t.string "balance", default: "0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tenant_id", null: false
    t.integer "payments_count", default: 0, null: false
    t.index ["tenant_id"], name: "index_cash_accounts_on_tenant_id"
  end

  create_table "charges", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "subscription_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "metadata"
    t.index ["subscription_id"], name: "index_charges_on_subscription_id"
    t.index ["tenant_id"], name: "index_charges_on_tenant_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tenant_id", null: false
    t.integer "balance", default: 0, null: false
    t.integer "payments_count", default: 0, null: false
    t.integer "projects_count", default: 0, null: false
    t.integer "payments_sum", default: 0, null: false
    t.index ["tenant_id"], name: "index_clients_on_tenant_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.text "content", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.bigint "member_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["member_id"], name: "index_comments_on_member_id"
    t.index ["tenant_id"], name: "index_comments_on_tenant_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tenant_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "roles", default: {}, null: false
    t.string "slug"
    t.integer "balance", default: 0, null: false
    t.integer "tasks_count", default: 0, null: false
    t.integer "payments_count", default: 0, null: false
    t.integer "payments_sum", default: 0, null: false
    t.index ["roles"], name: "index_members_on_roles", using: :gin
    t.index ["slug"], name: "index_members_on_slug", unique: true
    t.index ["tenant_id"], name: "index_members_on_tenant_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "payable_type", null: false
    t.bigint "payable_id", null: false
    t.integer "amount"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "cash_account_id", null: false
    t.index ["cash_account_id"], name: "index_payments_on_cash_account_id"
    t.index ["payable_type", "payable_id"], name: "index_payments_on_payable"
    t.index ["tenant_id"], name: "index_payments_on_tenant_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.string "currency"
    t.string "interval"
    t.integer "max_members"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "name"
    t.text "description"
    t.bigint "client_id", null: false
    t.string "payment_type"
    t.integer "price", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tasks_count", default: 0, null: false
    t.string "status", default: "active"
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["tenant_id"], name: "index_projects_on_tenant_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "tenant_id", null: false
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["tenant_id"], name: "index_subscriptions_on_tenant_id", unique: true
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "tag_id", null: false
    t.string "taggable_type", null: false
    t.bigint "taggable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable"
    t.index ["tenant_id"], name: "index_taggings_on_tenant_id"
  end

  create_table "tags", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "name"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tenant_id"], name: "index_tags_on_tenant_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "project_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "deadline"
    t.boolean "urgent"
    t.string "status", default: "planned", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "done_at"
    t.bigint "member_id"
    t.integer "creator_id", null: false
    t.integer "duration_minutes", default: 0, null: false
    t.index ["creator_id"], name: "index_tasks_on_creator_id"
    t.index ["member_id"], name: "index_tasks_on_member_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["tenant_id"], name: "index_tasks_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "members_count", default: 0, null: false
    t.index ["slug"], name: "index_tenants_on_slug", unique: true
  end

  create_table "user_identities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.text "auth"
    t.index ["user_id"], name: "index_user_identities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.integer "tenant_id"
    t.integer "members_count", default: 0, null: false
    t.string "slug"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "provider"
    t.string "name"
    t.string "image"
    t.boolean "superadmin", default: false
    t.string "language"
    t.string "time_zone", default: "UTC"
    t.integer "telegram_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "tenants"
  add_foreign_key "cash_accounts", "tenants"
  add_foreign_key "charges", "subscriptions"
  add_foreign_key "charges", "tenants"
  add_foreign_key "clients", "tenants"
  add_foreign_key "comments", "members"
  add_foreign_key "comments", "tenants"
  add_foreign_key "members", "tenants"
  add_foreign_key "members", "users"
  add_foreign_key "payments", "cash_accounts"
  add_foreign_key "payments", "tenants"
  add_foreign_key "projects", "clients"
  add_foreign_key "projects", "tenants"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "tenants"
  add_foreign_key "taggings", "tags"
  add_foreign_key "taggings", "tenants"
  add_foreign_key "tags", "tenants"
  add_foreign_key "tasks", "members"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "tenants"
  add_foreign_key "user_identities", "users"
end
