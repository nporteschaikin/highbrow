class AddTimestampsToImports < ActiveRecord::Migration[5.1]
  def change
    change_table :imports do |t|
      execute "TRUNCATE TABLE imports CASCADE;"

      t.timestamp :finished_at, null: true
      t.timestamps
    end
  end
end
