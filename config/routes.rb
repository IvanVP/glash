Glash::Application.routes.draw do
  # Static Pages
  scope controller: :pages do
    get 'greetings' => :greetings, as: :greetings
    get 'goodbye' => :goodbye, as: :goodbye
    get 'faq' => :faq,  as: :faq
    get 'help' =>:help,  as: :help
    get 'terms' =>:terms,  as: :terms
    get 'load_avatar' =>:load_avatar,  as: :load_avatar
  end
   
  ActiveAdmin.routes(self)

  get 'contacts/index'
  get 'contacts/show'
  get 'contacts/new'
  get 'contacts/create'
  get 'contacts/edit'
  get 'contacts/update'
  

  authenticated :user do
    root to: "base#index", :as => "base"
  end

  root to: "base#default"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
    member do
      get :avatar
    end
  end

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
