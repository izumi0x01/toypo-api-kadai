module Api
  module V1
    class StoresController < ActionController::API

      def create
        @store = Store.create(store_name: params[:store_name], store_description: params[:store_description],email: params[:email], password: params[:password]);

        if @store.save
          session[:store_id] = @store.id
          render json: @store
        else
          render json: { errors: @store.errors.full_messages }, status: 400
        end

      end
      
      def log_in
        @store = Store.find_by(email: params[:email])

        if Api::V1::Autheniticator.new(@store).autheniticate(params[:password])
          session[:store_id] = @store.id
          render json: @store
        else
          render json: { errors: ['ログインに失敗しました'] }, status: 401
        end

      end

      def log_out
        session.delete(:store_id)
      end

      def edit

        if current_store && params[:email].present? && params[:password].present? && params[:store_name].present?

          @current_store.email = params[:email]
          @current_store.hashed_password = BCrypt::Password.create(params[:password])
          @current_store.store_name = params[:store_name]
          @current_store.store_description = params[:store_description]


          render json: @current_store

          @current_store.save

        else
          render json: { errors: ['ログインしていません'] }, status: 401
        end

      end

      def me
        
        if current_store
          render json: @current_store
        end

      end

      private def current_store
        #Rubyでは最後に評価した式がメソッドの戻り値になる
        if session[:store_id]
          @current_store ||= Store.find_by(id: session[:store_id])
        end
      end

    end
  end
end
