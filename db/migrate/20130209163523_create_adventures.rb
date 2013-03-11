class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :from
      t.string :to
      t.datetime :departure_time
      t.integer :user_id

      t.timestamps
    end

    add_index "adventures", "user_id"
  end
end
