ActiveAdmin.register Idea do
  menu priority: 2

  index do
    actions
    column :id
    column :user
    column :category

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
    column :title
    column :synopsis
    column :problem
    column :background
    column :solution
    column :links
  end

  # index :as => :grid, :columns => 3 do |idea|
  #   link_to admin_idea_path(idea) do
  #     image_tag (image_for_idea(idea)), class: "img img-responsive", width: '70%', title: idea.title
  #   end
  # end

  index :as => :grid, :columns => 5, default: true do |idea|
    
    div do

      div :for => idea do
        h2 link_to idea.title, admin_idea_path(idea) 
        div do
          link_to idea.user.fullname, admin_idea_path(idea)
        end
        div do
          h6 'Аннотация :'
        end
        div do
          simple_format idea.synopsis
        end
      end
      div :for => idea  do
        link_to admin_idea_path(idea) do
          image_tag (image_for_idea(idea)), width: '100%', title: idea.title
        end
      end

      div do
        simple_format idea.problem
      end
      div do
        simple_format idea.background
      end
      div do
        simple_format idea.solution
      end
      div do
        simple_format idea.links
      end
      hr
    end
  end


  index :as => :block do |idea|
    
    div do

      div :for => idea   do
        h2 link_to idea.title, admin_idea_path(idea) 
        div do
          link_to idea.user.fullname, admin_idea_path(idea)
        end
        div do
          h6 'Аннотация :'
        end
        div do
          simple_format idea.synopsis
        end
      end
      div :for => idea  do
        if idea.assets.any?
          idea.assets.each do |image|
            div class: 'actadm_asset' do
              image_tag(image.url(:thumb))
            end
            # h6 image.url(:thumb)
          # link_to admin_idea_path(idea) do

          #   image_tag (image_for_idea(idea)), class: "img img-responsive", width: '20%', title: idea.title
          end
        end
      end

      div do
        simple_format idea.problem
      end
      div do
        simple_format idea.background
      end
      div do
        simple_format idea.solution
      end
      div do
        simple_format idea.links
      end
      hr
    end

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

  controller do
    def scoped_collection
      resource_class.includes(:user, :category) # prevents N+1 queries to your database
    end
  end
  
end