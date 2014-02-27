#
# Here we define the roles that each user could have.
# A user could have many roles, and each role could have many users.
# We have a many to many relationship between users and roles.
#
authorization do
  role :admin do
    has_permission_on [:adventures], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:users], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  role :adventurer do
    has_permission_on [:adventures], :to => [:index, :show, :new, :create]
    has_permission_on [:adventures], :to => [:edit, :update, :destroy] do
      if_attribute :user => is { user }
    end
  end
end
