class CreateUsersFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :users_followers do |t|
      t.references :user, foreign_key: { to_table: :users }, null: false, index: true
      t.references :follower, foreign_key: { to_table: :users }, null: false, index: true
      t.integer :status

      t.timestamps

      t.index ["user_id", "follower_id"], name: "unique_index_on_user_id_and_follower_id", unique: true
    end
  end
end
