Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'user', controllers: {
          registrations: 'api/v1/user/registrations'
      }
    end
  end

  # get 'static_pages/home'
  # get 'static_pages/help'
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  
end
