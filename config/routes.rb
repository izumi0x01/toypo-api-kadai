Rails.application.routes.draw do
  
  # get 'static_pages/home'
  # get 'static_pages/help'
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  namespace :api do
    namespace :v1 do
      resources :stores, only: [ :create ] do
        collection do
          # ログイン
          post 'log_in'  => "stores#log_in", as: :log_in 
          # ログアウト
          post 'log_out' => "stores#log_out", as: :log_out 
          # 登録内容の変更
          post 'edit' => "stores#edit", as: :edit 
          # session情報の獲得
          get 'me' => "stores#me" 
        end
      end 
    end
  end

end