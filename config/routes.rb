Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
    mount_devise_token_auth_for 'Store', at: 'store', controllers: {

      registrations: 'api/v1/store/registrations'
    }
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {

        registrations: 'api/auth/registrations'
    }
    end
  end

  # get 'static_pages/home'
  # get 'static_pages/help'
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  
end
