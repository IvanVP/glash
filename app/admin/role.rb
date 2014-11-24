ActiveAdmin.register Role do
  menu priority: 3
    remove_filter :roles_users

  form do |f|
  #   f.inputs "Main poll" do
  #     f.input :name
  #     f.input :description
  #   end

    f.inputs do
      f.has_many :users do |u|
        u.fullname
       end
    end

    f.buttons
  end

  # remove_filter roles_roles



  # index do
  #   actions
  #   column :id
  #   column :name
  #   column :description
  # end

  # index :as => :grid, :columns => 3 do |idea|
  #   link_to admin_idea_path(idea) do
  #     image_tag (image_for_idea(idea)), class: "img img-responsive", width: '70%', title: idea.title
  #   end
  # end


  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :fname, :mname, :lname, :name, :email, :avatar, :birthdate,
  #               :gender, :description, :slug, :role_id, :country_id
  #
 permit_params :name, :description
 permit_params(:user_roles => [:user_id, :role_id])
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  controller do
    # def scoped_collection
    #   resource_class.includes(:user, :category) # prevents N+1 queries to your database
    # end
  end
  
end