class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :uid
      t.string :provider
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.string :country
      t.string :about
      t.string :password_digest
      t.string :session_token
      t.boolean :admin
      t.string :image

      t.timestamps
    end

    # Add an index to the DB and enforce a unique validation
    # on the email column
    add_index "users", "email", :unique => true
    add_index "users", "session_token"
  end
end
