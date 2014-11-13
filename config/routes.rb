Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'home#index'

  get "/login",                           to: "users#login_form",                 as: "login_form"
  post "/login",                          to: "users#login",                      as: "login"
  get "/logout",                          to: "users#logout",                     as: "logout"

  post "/autocomplete_date/:term",        to: "items#autocomplete_date",          as: 'autocomplte_date'
  get "/search/:pantry_id",               to: "pantries#index",                   as: "search"
  post "/users/:user_id/pantries/:id",  to: "pantries#opt_out",                 as: "opt_out"

  resources :users, except: [:index] do
    resources :pantries, except: [:index] do
      get :autocomplete_prototype_name, :on => :collection
      resources :recipes, only: [:index]
      resources :items, except: [:index, :show]
    end
  end


  resources :invites
  resources :password_resets
  # get '/register' => 'users#new', as: 'new_user'
  # post '/register' => 'users#create' as: 'create_user'

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
