ActiveAdmin.register Role do

  index do
    column :id
    column :name
    column :description
  end




  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :fname, :mname, :lname, :name, :email, :avatar, :birthdate,
  #               :gender, :description, :slug, :role_id, :country_id
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end

