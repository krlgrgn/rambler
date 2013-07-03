class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :user_id
      t.integer :conversation_id
      t.timestamps
    end

    create_table :conversations do |t|
      t.timestamps
    end

    create_table :mailboxes do |t|
      t.integer :user_id
      t.timestamps
    end

    create_table :conversation_mailbox_maps do |t|
      t.integer :conversation_id
      t.integer :mailbox_id
      t.timestamps
    end

    create_table :conversation_message_maps do |t|
      t.integer :conversation_id
      t.integer :message_id
      t.timestamps
    end

    create_table :conversation_user_maps do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.timestamps
    end
  end
end
