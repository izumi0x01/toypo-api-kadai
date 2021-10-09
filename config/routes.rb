Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      
      # get 'store/index_connections' => 'store/stores#index_connections'
      # get 'user/index_connections' => 'user/users#index_connections'
      
      mount_devise_token_auth_for 'Store', at: 'store', controllers: {
        registrations: 'api/v1/store/registrations'
      }
      
      mount_devise_token_auth_for 'User', at: 'user', controllers: {
        registrations: 'api/v1/user/registrations'
      }

      namespace :user do
        resources :connections, only: [:create, :destroy, :show, :index]
      end

      namespace :staff do
        resources :connections, only: [:create, :destroy, :show, :index]
      end

      resources :stampcards, only: [:create, :destroy, :update, :show, :index]
      resources :stampcard_contents, only: [:crate, :destroy, :update, :show, :index]

    end
  end
  
end
