Rails.application.routes.draw do
  root 'users#new'

  post 'sessions' => 'sessions#create', as: 'login'
  delete 'sessions' => 'sessions#destroy', as: 'logout'  

  get 'users/new' => 'users#new', as: 'signin'  
  post 'users' => 'users#create', as: 'register'
  get 'users/:id/edit' => 'users#edit', as: 'edit_user'
  put 'users/:id' => 'users#update', as: 'update_user'
  get 'users/:id' => 'users#show', as: 'show_user'

  get 'events' => 'events#index', as: 'events'
  get 'events/:id' => 'events#show', as: 'show_event'
  post 'events' => 'events#create', as: 'create_event'
  get 'events/:id/edit' => 'events#edit', as: 'edit_event'
  put 'events/:id' => 'events#update', as: 'update_event'
  delete 'events/:id' => 'events#destroy', as: 'delete_event'
  
  get 'attendees/:id' => 'attendees#create', as: 'join'
  delete 'events/:id/attendees' => 'attendees#destroy', as: 'unjoin'

  post 'events/:id/comments' => 'comments#create', as: 'create_comment'

  post 'invites/:id' => 'invites#create', as: 'invite'
  get 'invites/:id/:status' => 'invites#destroy', as: 'response' 
  
  
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
