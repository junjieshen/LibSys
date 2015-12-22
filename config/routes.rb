Rails.application.routes.draw do
  resources :histories
  get 'sessions/new'

  resources :members
  resources :admins
  get 'welcome/index'
  resources :books
  get 'books_controller/Book'
  post '/search' => 'books#search'
  post '/borrow' => 'books#borrow'
  post '/checkout' => 'books#checkout'
  #get '/checkout' => 'books#checkout'
  get '/checkout/:id' => 'books#checkout'
  get 'list_book_history' => 'books#list_history'
  get 'list_member_history' => 'members#list_history'
  post 'return_book' => 'members#return_book'
  get '/books/:id/subscribe' => 'books#subscribe'
  get '/books/:id/unsubscribe' => 'books#unsubscribe'
  #Suggestions
  get '/suggestions' => 'suggestions#index'
  post '/suggestions' => 'suggestions#create'
  get '/suggestions/new' => 'suggestions#new', as: 'new_suggestion'

  get '/suggestions/:id/approve' => 'suggestions#approve', as: 'approve_suggestion'
  get '/suggestions/:id' => 'suggestions#show', as: 'suggestion'
  patch '/suggestions/:id' => 'suggestions#update'
  put '/suggestions/:id' => 'suggestions#update'
  delete '/suggestions/:id' => 'suggestions#destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get 'login_member' => 'sessions#new_member'
  post 'login_member' => 'sessions#create_member'
  delete 'logout' => 'sessions#destroy'
  get 'login_admin' => 'sessions#new_admin'
  post 'login_admin' => 'sessions#create_admin'

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
