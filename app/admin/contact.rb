ActiveAdmin.register Contact do
  menu priority: 3

  index do
    actions
    column :id
    column "Аватар" do |contact|
      image_tag(contact.user.avatar.url(:thumb), width: '25px')
    end
    column :user
    column :phone
    column :phone2
    column :skype
    column :show_skype
    column :site
    column :show_site
    column :vkontakte
    column :facebook
    column :odnoklassniki
    column :twitter
    column :linkedin
  end
  
 permit_params :user_id, :phone, :phone2, :skype, :show_skype, :site, :show_site, :vkontakte, :facebook, :odnoklassniki, :twitter, :linkedin
  
end