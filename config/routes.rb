Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'clients/index'
  
  devise_for :users
  get 'welcome/index'
  get "car/smonth/:num" => 'cars#smonth'
  get "car/autotech" => 'cars#autotech'
  
  get "welcome/smonth/:num" => 'welcome#smonth'
  get "reztocontract/:num" => 'cars#rez_to_contract'
  get "contract/clicontr/:num" => 'contract#clicontr'
  
  post "car/autotech" => 'cars#autotech'
  post "reznew" => 'cars#reznew'
  post "rez_to_contract" => 'cars#rez_to_contract'
  
  post "contract_to_arh" => 'cars#contract_to_arh'
  post "contracts/:id/contr" => 'contracts#contr'
  post "contracts/:id/show" => 'contracts#show'

  get 'clients/new'
  post 'clients/new'
  get 'clients/destroy'
  post 'clients/destroy'   
  
  get 'contracts/new'
  post 'contracts/new'
  get 'contracts/show'
  post 'contracts/show'
  get 'contracts/update'
  post 'contracts/update'  
  get 'contracts/edit'
  post 'contracts/edit'
  get 'contracts/destroy'
  post 'contracts/destroy' 
  get 'contracts/indexbroni'
  post 'contracts/indexbroni'
  get 'contracts/indexarc'
  post 'contracts/indexarc' 
  get 'contracts/newbroni'
  post 'contracts/newbroni'
  get 'contracts/contract2arh'
  post 'contracts/contract2arh'
  get 'contracts/broni2contract'
  post 'contracts/broni2contract'
  
  post "tehservices/new"
  get  "tehservices/new"
  post 'tehservices/index'
  get  'tehservices/index'
  post 'tehservices/create'
  get  'tehservices/create'
  patch 'tehservices/create'
  post "tehservices/edit"
  get  "tehservices/edit"
  post "tehservices/destroy"
  get  "tehservices/destroy"  
  
  get 'cars/smonth'
  post 'cars/smonth'
  get 'cars/index'
  post 'cars/index'
  get 'cars/new'
  post 'cars/new'
  get 'cars/destroy'
  post 'cars/destroy'
  get "cars/autotech"
  post "cars/autotech"  
  
  get 'cparams/show'
  post 'cparams/show'
 
  #post "clients/:client" => 'clients#update'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'cars#smonth'
  #resources :contracts  do
   # end
   
  resources :clients  do
    end  
  resources :cparams  do
    end   
  resources :contracts  do
    end
   resources :cars do
    resources :contracts  do
    end
    resources :wlongs  do
    end
    resources :tehservices  do
    end
  resources :user_notifier  do
    end  
  end

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
