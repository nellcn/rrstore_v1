Rails.application.routes.draw do

  get 'store/index'
  get 'store/show_product'
  get 'store/show_cart'
  get 'store/show_orders'
  get 'store/show_order'

  get 'store/add_to_cart'
  get 'store/edit_cart'
  post 'store/edit_cart'
  get 'store/remove_from_cart'

  get 'store/check_out'
  get 'store/generate_order'
  post 'store/generate_order'
  get 'store/show_new_order'

  get 'store/share_weibo'
  get 'store/go_to_pay'
  get 'store/pay'

  resources :users
  resources :products

  resources :sessions, only: [:new, :create, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'store#index'

  get '/help' => 'static_pages#help'
  get '/about' => 'static_pages#about'

  get '/signup' => 'users#new'
  get '/signin' => 'sessions#new'
  get '/signout' => 'sessions#destroy'#, as: :delete

  #get ':controller/:action'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #resources :products do

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
  #     #   end
end
