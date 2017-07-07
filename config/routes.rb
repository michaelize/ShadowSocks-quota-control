Rails.application.routes.draw do
  get 'home' => 'main#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    passwords: "users/passwords",
    unlocks: "users/unlocks",
    mailer: "users/mailer",
    confirmations: "users/confirmations"
  }


  get 'home/download_config' => 'main#download_config'
  get 'home/download_win_32' => 'main#download_win_32'
  get 'home/download_win_64' => 'main#download_win_64'
  get 'home/download_mac' => 'main#download_mac'
  get 'home/downloads' => 'main#config_files'
  get 'home/guide' => 'main#guide'
  get 'home/activities' => 'main#activities'
  get 'home/admin/users' => 'main#admin_users'

  get ':action' => 'static#:action'

  root 'static#index'

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

  #root to: "home#index"

end
