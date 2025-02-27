Anathief::Application.routes.draw do
  root :to => 'welcome#index'

  # match '/auth/fb_callback', :to => 'sessions#fb_callback', :as => 'sessions_fb_callback', via: [:get, :post]
  match '/auth/guest', :to => 'sessions#guest_in', :as => 'sessions_guest_in', via: [:get, :post]
  match '/auth/logout', :to => 'sessions#logout', :as => 'sessions_logout', via: [:get, :post]

  match '/games/list', :to => 'games#list', :as => 'games_list', via: [:get, :post]
  match '/games/create', :to => 'games#create', :as => 'games_create', via: [:get, :post]
  match '/games/get_token', :to => 'games#get_token', :as => 'games_get_token', via: [:get, :post]

  match '/play/:id', :to => 'play#play', :as => 'play', via: [:get, :post]
  match '/play/:id/invite_form', :to => 'play#invite_form', :as => 'play_invite_form', via: [:get, :post]

  match '/bots/add', :to => 'bots#add', :as => 'bots_add', via: [:get, :post]
  match '/bots/list', :to => 'bots#list', :as => 'bots_list', via: [:get, :post]
  match '/bots/remove', :to => 'bots#remove', :as => 'bots_remove', via: [:get, :post]
  match '/bots/change', :to => 'bots#change', :as => 'bots_change', via: [:get, :post]

  match '/internal', :to => 'internal#endpoint', :as => 'internal_endpoint', via: [:get, :post]

  #resources :games, :module => 'admin', :path => '/admin/games'
  #namespace 'admin' do
    #resources :games
  #end

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
