class CreateUsersConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :users_connections do |t|
      t.references :source_user, foreign_key: { to_table: :users }, null: false, index: true
      t.references :target_user, foreign_key: { to_table: :users }, null: false, index: true
      t.integer :status

      t.timestamps

      t.index ["source_user_id", "target_user_id"], name: "unique_index_on_source_and_target_user_id", unique: true
    end
  end
end
