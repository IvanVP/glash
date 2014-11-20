authorization do
  role :guest do
    has_permission_on :ideas, :submit, :to => :read
    has_permission_on :contacts, :to => [:read, :create]
    # add permissions for guests here, e.g.
    # has_permission_on :conferences, :to => :read
  end

  # permissions on other roles, such as
  role :administrator do
    has_permission_on :ideas, :submit, :to => :manage
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
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :create, :includes => :new
  privilege :read, :includes => [:index, :show]
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end