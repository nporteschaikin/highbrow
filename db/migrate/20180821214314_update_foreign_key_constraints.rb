class UpdateForeignKeyConstraints < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :import_check_ins, :check_ins
    add_foreign_key    :import_check_ins, :check_ins, on_delete: :cascade

    remove_foreign_key :import_check_ins, :imports
    add_foreign_key    :import_check_ins, :imports, on_delete: :cascade

    remove_foreign_key :check_in_tagged_users, :check_ins
    add_foreign_key    :check_in_tagged_users, :check_ins, on_delete: :cascade

    remove_foreign_key :check_in_tagged_users, :users
    add_foreign_key    :check_in_tagged_users, :users, on_delete: :cascade

    remove_foreign_key :check_ins, :users
    add_foreign_key    :check_ins, :users, on_delete: :cascade

    remove_foreign_key :imports, :users
    add_foreign_key    :imports, :users, on_delete: :cascade
  end
end
