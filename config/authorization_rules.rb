authorization do
  role :guest do
    has_permission_on :registrations, :to => :create

    has_permission_on :ideas, :to => :read, :join_by => :and do
      # if_attribute moderated: true
      # if_attribute archieved: false
      if_attribute moderated: true, archieved: false

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

    has_permission_on :ideas, :to => [:read, :create, :update]

    has_permission_on :submit, :to => [:show, :edit, :update] do
      if_attribute published: false
    end

    has_permission_on :ideas, :to => [:delete]
    has_permission_on :ideas, :to => [:vote]

    has_permission_on :comments, :to => [:create]

    has_permission_on :assets, :to => [:create, :delete]
  end

  role :moderator do
    includes :member

    has_permission_on :comments, :to => [:index, :delete, :moderate]
  end

  role :administrator do
    includes :moderator

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