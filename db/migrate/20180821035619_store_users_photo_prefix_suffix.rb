class StoreUsersPhotoPrefixSuffix < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :photo_prefix, :string, null: true
    add_column :users, :photo_suffix, :string, null: true
    remove_column :users, :avatar_url

    # Clean up: Remove unused `html_url` attribute
    remove_column :users, :html_url

    # Postgres doesn't let us manipulate column order and I'm feeling very
    # particular right now.
    add_column :users, :created_at_new, :timestamp, null: true
    add_column :users, :updated_at_new, :timestamp, null: true
    execute <<~SQL
      UPDATE public.users
      SET created_at_new = created_at,
          updated_at_new = updated_at
    SQL
    change_column_null :users, :created_at_new, false
    change_column_null :users, :updated_at_new, false
    remove_column      :users, :created_at
    remove_column      :users, :updated_at
    rename_column      :users, :created_at_new, :created_at
    rename_column      :users, :updated_at_new, :updated_at
  end
end
