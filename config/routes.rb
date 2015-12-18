Rails.application.routes.draw do
  get 'terms' => 'static_pages#terms'

  get 'companies/signup' => 'companies#new'

  get 'testers/signup' => 'testers#new'

  devise_for :users, controllers: { sessions: "users/sessions" }

  get 'about' => 'aboutus#index_aboutus'

  get 'techexperts' => 'techexperts#index_techexpert'

  get 'products' => 'products#index_product'

  get 'processes' => 'processes#index_process'

  get 'prices' => 'prices#index_price'

  get 'faqs' => 'faqs#index_faq'

  get 'contacts' => 'contacts#index_contact'

  get 'career' => 'career#index_career'

  get 'busters' => 'busters#index_buster'

  get 'blogs' => 'blogs#index_blog'

  get 'home' => 'home#index'

  resources :testers
  resources :companies

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
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
