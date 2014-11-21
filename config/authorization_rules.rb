authorization do
  role :guest do
    has_permission_on :registrations, :to => :create
    has_permission_on :ideas, :to => :read do
      if_attribute moderated: true
    end
  end


  role :member do
    has_permission_on :users, :to => :read
    has_permission_on :registrations, :to => :change

    has_permission_on :users, :to => [:update, :avatar, :load_avatar] do
      if_attribute :id => is {user.id}
    end

    has_permission_on :contacts, :to => :change do
      if_attribute :user_id => is {user.id}
    end

    

    has_permission_on :ideas, :submit, :to => :manage

  end

  role :moderator do
    # has_permission_on :ideas, :submit, :to => :read
  end

  # permissions on other roles, such as
  role :administrator do
    has_permission_on :ideas, :submit, :to => :manage
    has_permission_on :ideas, :to => :moderate
  end
  # role :user do
  #   has_permission_on :conferences, :to => [:read, :create]
  #   has_permission_on :conferences, :to => [:update, :delete] do
  #     if_attribute :user_id => is {user.id}
  #   end
  # end
  # See the readme or GitHub for more examples
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :change, :delete]
  privilege :create, :includes => :new
  privilege :read, :includes => [:index, :show]
  privilege :change, :includes => [:edit, :update]
  privilege :edit
  privilege :update
  privilege :delete, :includes => :destroy
end