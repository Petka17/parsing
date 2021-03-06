Parsing::Application.routes.draw do
  
  root 'static_pages#home'

  resources :categories do
    collection do
      post 'extract' => 'categories#extract_all'
    end

    member do
      post 'extract' => 'categories#extract_sub'
    end

    member do
      post 'extract_prod' => 'categories#extract_sub_prod'
    end
  end

  resources :subcategories do
    collection do
      post 'extract' => 'subcategories#extract_all'
    end

    member do
      post 'extract' => 'subcategories#extract_pg'
      post 'extract_prod'
    end
  end

  resources :product_groups do
    member do
      post 'extract' => 'product_groups#extract_prod'
    end
  end

  match '/get_status/:id', to: 'delayed_jobs#get_status', via: 'get'


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
