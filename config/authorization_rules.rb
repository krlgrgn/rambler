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
    has_permission_on [:users], :to => [:index, :show]
    has_permission_on [:users], :to => [:edit, :show, :update, :destroy] do
      # In this case I was trying to allow only the current logged in user edit, update or destroy himself/herself.
      # So using something like: if_attribute :user => is { user } wont work because:
      # the user symbol here is a method that is being called on the object in the view (a user in this case) and will
      # through an erro. To work around this I used the below to check if the user in the view was the current user.
      if_attribute :session_token => is { user.session_token }
    end
  end
  role :guest do 
    has_permission_on [:users], :to => [:new, :create]
  end
end
