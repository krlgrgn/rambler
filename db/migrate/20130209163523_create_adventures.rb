class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :from
      t.string :to
      t.datetime :departure_time

      t.timestamps
    end
  end
end
