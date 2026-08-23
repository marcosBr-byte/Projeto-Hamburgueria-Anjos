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

ActiveRecord::Schema[8.1].define(version: 2026_08_23_152517) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "carrinhos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_carrinhos_on_user_id"
  end

  create_table "item_carrinhos", force: :cascade do |t|
    t.bigint "carrinho_id", null: false
    t.datetime "created_at", null: false
    t.bigint "produto_id", null: false
    t.integer "quantidade"
    t.datetime "updated_at", null: false
    t.index ["carrinho_id"], name: "index_item_carrinhos_on_carrinho_id"
    t.index ["produto_id"], name: "index_item_carrinhos_on_produto_id"
  end

  create_table "item_pedidos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "pedido_id", null: false
    t.string "preco_unitario"
    t.bigint "produto_id", null: false
    t.integer "quantidade"
    t.datetime "updated_at", null: false
    t.index ["pedido_id"], name: "index_item_pedidos_on_pedido_id"
    t.index ["produto_id"], name: "index_item_pedidos_on_produto_id"
  end

  create_table "pedidos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "total", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_pedidos_on_user_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.boolean "ativo"
    t.string "categoria"
    t.datetime "created_at", null: false
    t.text "descricao"
    t.integer "estoque"
    t.string "nome"
    t.decimal "preco", precision: 10, scale: 2
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "nome"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carrinhos", "users"
  add_foreign_key "item_carrinhos", "carrinhos"
  add_foreign_key "item_carrinhos", "produtos"
  add_foreign_key "item_pedidos", "pedidos"
  add_foreign_key "item_pedidos", "produtos"
  add_foreign_key "pedidos", "users"
end
