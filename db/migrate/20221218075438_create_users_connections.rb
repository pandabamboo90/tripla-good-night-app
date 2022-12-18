class CreateUserConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :users_connections do |t|
      t.references :source_user, null: false, foreign_key: true, index: true
      t.references :target_user, null: false, foreign_key: true, index: true
      t.integer :status

      t.timestamps

      t.index ["source_user_id", "target_user_id"], name: "unique_index_on_source_and_target_user_id", unique: true
    end
  end
end
