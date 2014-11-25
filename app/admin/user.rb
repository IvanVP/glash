ActiveAdmin.register User do
  menu priority: 1
  remove_filter :users_roles
  config.sort_order = "updated_at_desc"
  # http://rails.hasbrains.org/questions/369


  index do 
    selectable_column
    column "Аватар" do |user|
      image_tag(user.avatar.url(:thumb), width: '25px')
    end
    column "Имя, Фамилия", :fullname
    column :name
    column :email
    column :enabled

    column 'Role' do |r|
      r.roles.map(&:name).join(', ')
    end
    column :country
    column :slug
    column :sign_in_count

    actions
  end
  action_item :only => :edit do
    link_to('Редактировать Роли', show_role_admin_user_path(user)) 
  end

  index :as => :grid, :columns => 10 do |user|
    

    div :for => user do
      h4 link_to user.fullname, admin_user_path(user) 
      div do
        link_to admin_user_path(user) do
          image_tag(user.avatar.url(:thumb))
        end
      end
      hr
    end
  end


  member_action :show_role, :method => :get do
    @user = User.friendly.find(params[:id])
  end

  member_action :role, :method => :patch do
    @user = User.friendly.find(params[:id])
    @user.roles = []
    params[:user][:role_ids].each { |r| resource.roles.push(Role.find(r)) unless r.blank? }
    p @user.roles.inspect
    update!
  end

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :fname, :mname, :lname, :name, :email, :avatar, :birthdate,
  #               :gender, :description, :slug, :country_id, :user=> [:role_ids => []]
  # permit_params( :user_roles => [:user_id, :role_id])
  #
  # or
  #
  permit_params do
   permitted = [:fname, :mname, :lname, :name, :email, :slug, :avatar, :birthdate, :show_birthdate, :gender, :show_gender, :description, :warnings, :enabled, :country_id]
   permitted << {role_ids: []}
   permitted
  end



  controller do
    def scoped_collection
      resource_class.includes(:country, :roles) # prevents N+1 queries to your database
    end
  end
  
end


