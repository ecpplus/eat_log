EatLog::Application.routes.draw do
  resources :black_words
  resources :tweets, :only => :destroy

  root :to => "hot_food#index"

  #map.home 'home', :controller => 'user', :action => 'home'
  match 'home', :to => 'user#home', :as => 'home'

  scope :module => 'admin' do
    match 'admin/admin/:action(/:id)', :to => 'admin'
    resources :black_words
    #match 'admin/black_word/:action(/:id)', :to => 'black_word'
  end
  

  match 'auth/:action(/:id)', :to => 'auth'
  #match 'tweet/:action(/:id)', :to => 'tweet'
  match 'about/:action(/:id)', :to => 'about'

  match ':id/:month', :to => 'user#show'
  match ':id', :to => 'user#show'

  match ':controller/:action/:id'
  match ':controller/:action/:id.:format'

  #map.connect 'admin/admin/:action/:id', :controller => 'admin/admin'
  #map.connect 'admin/black_word/:action/:id', :controller => 'admin/black_word'
  #map.connect 'auth/:action/:id', :controller => 'auth'
  #map.connect 'tweet/:action/:id', :controller => 'tweet'
  #map.connect 'about/:action/:id', :controller => 'about'

  #map.connect ':id/:month', :controller => 'user', :action => 'show'
  #map.connect ':id', :controller => 'user', :action => 'show'
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'

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
