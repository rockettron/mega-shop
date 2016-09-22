Rails.application.routes.draw do

  root 'users#index'

  resources :users do
    get 'cart', to: 'carts#show'
    match 'cart/check_out', to: 'carts#check_out', via: [:get, :post] 
    match 'cart/add_product', to: 'carts#add_product', via: [:get, :post]
    match 'cart/delete_product', to: 'carts#delete_product', via: [:get, :post] 
    
    resources :orders, shallow: true
    match 'replenish_balance', on: :member, via: [:get, :patch]
  end
  match '/sign_up', to: 'users#new', via: [:get]


  resources :orders do
    get 'last', on: :collection
  end

  get 'orders/:id/:user_id', as: 'user_orders_x', to: 'orders#display'  #настройка нересурсного маршрута
  post 'orders/:id/:user_id/', to: 'orders#pay'       #эти две строчки сделаны в качестве упражнения
  
  resources :products do
    get 'top10', on: :collection
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
