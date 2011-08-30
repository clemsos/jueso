Jueso::Application.routes.draw do 
  
  #Home page
  root :to => "pages#home"
  
  #Static pages
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/faq',    :to => 'pages#faq'
  match '/home',    :to => 'pages#home'
  
  
  #Portfolio 
  match '/at/:alias', :to => "galleries#portfolio"
  
  #  User management : devise_for :users  
  devise_for :users do 
    get "signin", :to => "devise/sessions#new"
    get "signout", :to => "devise/sessions#destroy"
  end

  #proposals
  resources :proposals
  match 'submit', :to => 'proposals#new'
  match 'submit/guidelines', :to => 'proposals#guidelines'

  # Profile : perso management
  match 'profile', :to => 'profile#home'
  resources :microposts, :only => [:destroy]
  
  namespace :profile do
    match "/thanks" => "profile#thanks"
      resources :change_roles, :only => [:create, :new, :show]
      resources :microposts, :only => [:create]
      resources :proposals, :only => [:show, :index]
      resources :projects, :only => [:show, :index, :edit] do
        resources :updates
      end
      resources :proposals do 
        resources :projects, :only => [:create, :new]
      end
      resources :galleries do 
        resources :uploads
        get 'add_files', :to => 'galleries#add_files'
      end
  end
  
  resources :uploads, :only =>[:show]
  
  scope "/remote" do
    match "/show_pic" => "uploads#show_pic"
    match "/show_crop" => "uploads#show_crop"    
    match "/avatar_crop" => "users#show_crop"
    match "/avatar_update" => "users#avatar_update"
  end
  
  match '/passchange' => 'users#passchange', :as => 'passchange'

  #microposts

  
  #features
  resources :leads, :only => [:index]  
      
  #projects
  resources :projects do
    resources :backs, :only => [:create]
    resources :comments, :only => [:create]
    resources :updates, :only => [:create]
    match "back", :to => "backs#new", :as => 'back'
    match "backs", :to => "projects#backs", :as => 'backs'
    match "updates", :to => "projects#updates", :as => 'updates'
    match "update", :to => "projects#update", :as => 'update'
    match "comments", :to => "projects#comments", :as => 'comments'
    match "description", :to => "projects#description", :as => 'description'
  end 
  get "/projects/cat/cloud", :to => "projects#category_cloud", :as => 'category_cloud'
  get 'projects/cat/:id' => 'projects#category', :as => :category
  resources :rewards


  #Users  
  resources :relationships, :only => [:create, :destroy]  #follow / unfollow
  resources :favorites, :only => [:create, :destroy]  #favorites

  resources :users, :controllers => { :sessions => :sessions} do    
    member do
      get :following, :followers
    end
    
    match 'avatar' => 'users#avatar', :as => 'avatar'  
    match "projects", :to => "users#projects", :as => 'projects'
    match "backs", :to => "users#backs", :as => 'backs'
    match "favorites", :to => "users#favorites", :as => 'favorites'
    match "portfolio", :to => "galleries#portfolio"    
    resources :galleries

  end
  
  #short url for gallerie
  # match '/at/:alias', :to => "galleries#portfolio"

  #Admin
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
