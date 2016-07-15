Rails.application.routes.draw do
  
  get 'clients/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'welcome/index'
  get "car/smonth/:num" => 'cars#smonth'
  get "car/autotech" => 'cars#autotech'
  get "welcome/smonth/:num" => 'welcome#smonth'
  get "reztocontract/:num" => 'cars#rez_to_contract'
  
  get "contract_to_arh/:num" => 'cars#contract_to_arh'
  get "car/rez" => 'cars#rez'
  
  get "tehservices/new" => 'tehservices#new'
  get "tehservices/list" => 'tehservices#list'
  
  post "car/rez" => 'cars#rez'
  post "car/rezdoc" => 'cars#rezdoc'
  post "car/reznew" => 'cars#reznew'
  
  post "car/autotech" => 'cars#autotech'
  post "reznew" => 'cars#reznew'
  post "rez_to_contract" => 'cars#rez_to_contract'
  
  post "contract_to_arh" => 'cars#contract_to_arh'
  post "car/contractnew" => 'cars#contractnew'
  post "car/contr" => 'cars#contr'
  post "client/new" => 'clients#new'
  
  post "tehservices/newto" => 'tehservices#newto'
  post "tehservices/new" => 'tehservices#new'
  
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
     get :autocomplete_client_pseria, :on => :collection
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
