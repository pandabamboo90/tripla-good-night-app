class CreateSleepRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_records do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.integer :length_in_seconds, null: false, default: 0
      t.integer :hours, null: false, default: 0
      t.integer :minutes, null: false, default: 0
      t.integer :seconds, null: false, default: 0

      t.timestamps
    end
  end
end
