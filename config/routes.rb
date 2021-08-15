Rails.application.routes.draw do
  
  
  namespace :v1 do 
    mount_devise_token_auth_for 'Store', at: 'auth'
  end

  # get 'static_pages/home'L
  # get 'static_pages/help'
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlg
  

  # namespace :api do
  #   namespace :v1 do
  #     resources :stores, only: [ :create ] do
  #       collection do
  #         # ログイン
  #         post 'log_in'  => "stores#log_in", as: :log_in 
  #         # ログアウト
  #         post 'log_out' => "stores#log_out", as: :log_out 
  #         # 登録内容の変更
  #         post 'update' => "stores#edit", as: :edit 
  #         # session情報の獲得
  #         get 'me' => "stores#me"
  #       end
  #     end 
  #   end
  # end

end