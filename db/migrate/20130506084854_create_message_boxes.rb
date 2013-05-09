class CreateMessageBoxes < ActiveRecord::Migration
  def change
    create_table :message_boxes do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
