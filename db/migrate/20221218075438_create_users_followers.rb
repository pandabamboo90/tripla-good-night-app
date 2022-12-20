class CreateUsersFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :users_followers do |t|
      t.references :user, foreign_key: { to_table: :users }, null: false, index: true
      t.references :following_user, foreign_key: { to_table: :users }, null: false, index: true
      t.integer :status

      t.timestamps

      t.index ["user_id", "following_user_id"], name: "unique_index_on_user_id_and_following_user_id", unique: true
    end
  end
end
