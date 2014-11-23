ActiveAdmin.register User do
  menu priority: 1
  remove_filter :users_roles
  # filter :users_roles, as: :check_boxes
  config.sort_order = "updated_at_desc"
  # http://rails.hasbrains.org/questions/369


  index do
    selectable_column
    column "Имя, Фамилия", :fullname
    column :name
    column :email
    column :enabled
    # column :user.ideas

    column 'Role' do |r|
      r.roles.map(&:name).join(', ')
    end
    column :country
    column :slug
    column :sign_in_count
    actions
  end

  index :as => :grid, :columns => 10 do |user|
    

    div :for => user do
      h4 link_to user.fullname, admin_user_path(user) 
      div do
        link_to admin_user_path(user) do
          image_tag(user.avatar.url(:thumb))
        end
      end

    # div do
    #
    # end
    # div do
    #
    # end
    # div do
    #
    # end
    # div do
    #
    # end
      hr
    end
  end

  # show do |u|
  #   attributes_table do
  #     row :title
  #     row :image do
  #       image_tag(u.avatar.url(:medium))
  #     end
  #   end
  #   active_admin_comments
  # end



  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :fname, :mname, :lname, :name, :email, :avatar, :birthdate,
                :gender, :description, :slug, :country_id
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  controller do
    def scoped_collection
      resource_class.includes(:country, :roles) # prevents N+1 queries to your database
    end
  end
  
end
