class AddShoutToCheckIns < ActiveRecord::Migration[5.1]
  def change
    add_column :check_ins, :shout, :string, null: true

    # Postgres doesn't let us manipulate column order and I'm feeling very
    # particular right now.
    add_column :check_ins, :created_at_new, :timestamp, null: true
    add_column :check_ins, :updated_at_new, :timestamp, null: true
    execute <<~SQL
      UPDATE public.check_ins
      SET created_at_new = created_at,
          updated_at_new = updated_at
    SQL
    change_column_null :check_ins, :created_at_new, false
    change_column_null :check_ins, :updated_at_new, false
    remove_column      :check_ins, :created_at
    remove_column      :check_ins, :updated_at
    rename_column      :check_ins, :created_at_new, :created_at
    rename_column      :check_ins, :updated_at_new, :updated_at
  end
end
