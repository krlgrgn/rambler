class CreateRoles < ActiveRecord::Migration
  def change
  	create_table :roles do |t|
  	  t.string :role

  	  t.timestamps
  	end

  	create_join_table :users, :roles, table_name: :user_role_maps

  	# Add some roles
  	Role.reset_column_information

  	Role.create(role: "adventurer")
  	Role.create(role: "admin")
  end
end
