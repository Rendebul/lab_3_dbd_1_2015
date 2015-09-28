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

ActiveRecord::Schema.define(version: 0) do

  create_table "AMISTAD", id: false, force: :cascade do |t|
    t.integer "ID_USUARIO",     limit: 4, null: false
    t.integer "USU_ID_USUARIO", limit: 4, null: false
  end

  add_index "AMISTAD", ["USU_ID_USUARIO"], name: "FK_RELATIONSHIP_7", using: :btree

  create_table "AUDITORIA", primary_key: "ID_AUDITORIA", force: :cascade do |t|
    t.integer  "AUD_ID_USUARIO", limit: 4
    t.string   "AUD_ID_TUPLA",   limit: 50
    t.string   "NOMBRE_TABLA",   limit: 20,   null: false
    t.string   "VALOR_ANTIGUO",  limit: 3000
    t.string   "VALOR_NUEVO",    limit: 3000
    t.datetime "FECHA",                       null: false
    t.string   "ACCION",         limit: 10,   null: false
  end

  create_table "CALIFICACION", id: false, force: :cascade do |t|
    t.integer "ID_USUARIO",   limit: 4,               null: false
    t.integer "ID_FOTO",      limit: 4,               null: false
    t.decimal "CALIFICACION",           precision: 1, null: false
  end

  add_index "CALIFICACION", ["ID_FOTO"], name: "FK_POSEE1", using: :btree

  create_table "COMENTARIO", primary_key: "ID_COMENTARIO", force: :cascade do |t|
    t.integer  "ID_USUARIO",        limit: 4
    t.integer  "ID_FOTO",           limit: 4,    null: false
    t.string   "COMENTARIO",        limit: 1000, null: false
    t.boolean  "ANONIMO",                        null: false
    t.boolean  "ACTIVO_COMENTARIO",              null: false
    t.datetime "FECHA_COMENTARIO",               null: false
  end

  add_index "COMENTARIO", ["ID_FOTO"], name: "FK_POSEE2", using: :btree
  add_index "COMENTARIO", ["ID_USUARIO"], name: "FK_COMENTA", using: :btree

  create_table "DEPOSITO", primary_key: "ID_DEPOSITO", force: :cascade do |t|
    t.integer  "ID_USUARIO",     limit: 4,  null: false
    t.datetime "FECHA_DEPOSITO",            null: false
    t.integer  "MONTO",          limit: 4,  null: false
    t.string   "NUMERO_CUENTA",  limit: 50, null: false
  end

  add_index "DEPOSITO", ["ID_USUARIO"], name: "FK_RELATIONSHIP_9", using: :btree

  create_table "FOTO", primary_key: "ID_FOTO", force: :cascade do |t|
    t.integer  "ID_USUARIO",   limit: 4,    null: false
    t.string   "NOMBRE_FOTO",  limit: 200,  null: false
    t.string   "TITULO",       limit: 50,   null: false
    t.string   "DESCRIPCION",  limit: 2000, null: false
    t.boolean  "ACTIVO_FOTO",               null: false
    t.datetime "FECHA_SUBIDA",              null: false
  end

  add_index "FOTO", ["ID_USUARIO"], name: "FK_SUBE", using: :btree

  create_table "FOTOS_PARA_USU", id: false, force: :cascade do |t|
    t.integer  "ID_FOTO",          limit: 4,    default: 0, null: false
    t.integer  "ID_USUARIO",       limit: 4,                null: false
    t.string   "NOMBRE_USUARIO",   limit: 100,              null: false
    t.string   "APELLIDO_USUARIO", limit: 50,               null: false
    t.boolean  "GOLD",                                      null: false
    t.string   "NOMBRE_FOTO",      limit: 200,              null: false
    t.string   "TITULO",           limit: 50,               null: false
    t.string   "DESCRIPCION",      limit: 2000,             null: false
    t.datetime "FECHA_SUBIDA",                              null: false
  end

  create_table "USUARIO", primary_key: "ID_USUARIO", force: :cascade do |t|
    t.string   "EMAIL_USUARIO",            limit: 100,               null: false
    t.string   "NOMBRE_USUARIO",           limit: 100,               null: false
    t.string   "APELLIDO_USUARIO",         limit: 50,                null: false
    t.string   "PASSWORD_USUARIO",         limit: 50,                null: false
    t.boolean  "ADMIN",                                              null: false
    t.boolean  "BLOQUEADO",                                          null: false
    t.boolean  "ACTIVO_USUARIO",                                     null: false
    t.integer  "SEXO_USUARIO",             limit: 4,                 null: false
    t.date     "FECHA_NACIMIENTO",                                   null: false
    t.decimal  "CANT_FOTOS_DIA",                       precision: 1, null: false
    t.datetime "FECHA_ULTIMA_FOTO_SUBIDA"
    t.boolean  "GOLD",                                               null: false
  end

  create_table "USUARIOS_PARA_USU", id: false, force: :cascade do |t|
    t.integer "ID_USUARIO",       limit: 4,   default: 0, null: false
    t.string  "NOMBRE_USUARIO",   limit: 100,             null: false
    t.string  "APELLIDO_USUARIO", limit: 50,              null: false
    t.integer "SEXO_USUARIO",     limit: 4,               null: false
    t.string  "EMAIL_USUARIO",    limit: 100,             null: false
    t.date    "FECHA_NACIMIENTO",                         null: false
    t.boolean "GOLD",                                     null: false
  end

  add_foreign_key "AMISTAD", "USUARIO", column: "ID_USUARIO", primary_key: "ID_USUARIO", name: "FK_RELATIONSHIP_8"
  add_foreign_key "AMISTAD", "USUARIO", column: "USU_ID_USUARIO", primary_key: "ID_USUARIO", name: "FK_RELATIONSHIP_7"
  add_foreign_key "CALIFICACION", "FOTO", column: "ID_FOTO", primary_key: "ID_FOTO", name: "FK_POSEE1"
  add_foreign_key "CALIFICACION", "USUARIO", column: "ID_USUARIO", primary_key: "ID_USUARIO", name: "FK_CALIFICA"
  add_foreign_key "COMENTARIO", "FOTO", column: "ID_FOTO", primary_key: "ID_FOTO", name: "FK_POSEE2"
  add_foreign_key "COMENTARIO", "USUARIO", column: "ID_USUARIO", primary_key: "ID_USUARIO", name: "FK_COMENTA"
  add_foreign_key "DEPOSITO", "USUARIO", column: "ID_USUARIO", primary_key: "ID_USUARIO", name: "FK_RELATIONSHIP_9"
  add_foreign_key "FOTO", "USUARIO", column: "ID_USUARIO", primary_key: "ID_USUARIO", name: "FK_SUBE"
end
