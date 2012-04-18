FilmProjectRails::Application.routes.draw do

  resources :posts do
    resources :comments
  end

  match "/blog/", :to => "posts#index"

  match "/blog/:id", :to => "posts#show"

  get "home/index"
  resources :task_categories

  resources :reminders

  match '/assets', :to => 'assets#index', :via => :get
  match '/assets/upload', :to => 'assets#new', :via => :get
  match '/assets', :to => 'assets#create', :via => :post
  match '/assets/:id', :to => 'assets#show'

  match "/projects", :to => "projects#change_project", :via => "post"
  match "/projects/menu", :to => "projects#menu"
  match '/projects/index', :to => 'projects#index'
  match '/projects/join', :to => 'projects#join'
  match '/projects/joinaction', :to => 'projects#joinaction', :via => :post
  match '/projects/:id', :to => 'projects#switch' , :via => :post
  resources :projects

  match '/notifications', :to => 'notifications#index'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :users

  # Viewing your contacts
  match '/contacts/all', :to => 'users#contacts_all'
  match '/contacts/projects', :to => 'users#contacts_by_project'
  match '/contacts/roles', :to => 'users#contacts_by_user_role'

  resources :user_roles

  resources :sessions, :pathnames => { :new => 'signin' }
  resources :signups, :only => [:new, :create], :pathnames => { :new => 'signup'}
  match '/tasks/menu', :to => 'tasks#menu'
  resources :tasks


  match '/signup', :to => 'signups#new'
  match '/signout', :to => 'sessions#destroy'
  match '/signin', :to => 'sessions#new'
  match '/guest', :to => 'sessions#guest'

  match '/about', :to => 'home#about'
  match '/comingsoon', :to => 'home#comingsoon'
  match '/changelog', :to => 'changelogs#index'
  #match '/users/new', :to => 'users#create', :via => :post
  match '/auth/:provider/callback', :to => 'sessions#create_facebook'
  match '/auth/failure' => redirect("/")
  match '/oauth2callback', :to => 'sessions#create_google'
  #abingo routing
  match 'experiments(/:action(/:id))', :to => 'abingo_dashboard', :as => :bingo




  #...
  #  # You can have the root of your site routed with "root"
  #    # just remember to delete public/index.html.
        root :to => "home#index"
end
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
