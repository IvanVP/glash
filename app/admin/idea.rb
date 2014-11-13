ActiveAdmin.register Idea do
  menu priority: 2

  index do
    actions
    column :id
    column :user
    column :category

    column :title
    column :synopsis
    column :problem
    column :background
    column :solution
    column :links
    column :published
    column :published_at
    column :moderated
    column :moderated_at
    column :archieved
    column :archieved_at
    column :created_at
    column :updated_at
    column :views
    column :show_on_main_page
    column :status
  end




  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :fname, :mname, :lname, :name, :email, :avatar, :birthdate,
  #               :gender, :description, :slug, :role_id, :country_id
  #
 permit_params :user_id , :category_id , :title , :synopsis , :problem , :background , :solution , :links , :published , :published_at , :moderated , :moderated_at , :archieved , :archieved_at , :created_at , :updated_at , :views , :show_on_main_page , :status
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end