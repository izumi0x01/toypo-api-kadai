class Api::V1::User::ConnectionsController < ApplicationController
    
    before_action :authenticate_api_v1_user!

    def index

        #コネクションレコードの一覧を参照   
        exist_connections = current_api_v1_user.connections

        #コネクションレコードの一覧をレスポンスに渡すことができたかどうかの確認
        if exist_connections.present?
            render json: exist_connections, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end

    end

    def show

        #コネクションレコードを参照
        exist_connection = current_api_v1_user.connections.find_by_id(params[:id])

        #コネクションレコードをレスポンスに渡すことができたかどうかの確認
        if exist_connection.present?
            render json: exist_connection, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end

    end

    def create 

        #コネクションレコードを参照   
        exist_connection = current_api_v1_user.connections.find_by(store_id: params[:store_id])

        #コネクションレコードが存在するかの確認
        if exist_connection.present?
            render json: {error: 'connection record was already registored'}, status: :bad_request and return
        end

        #ストアレコードの参照
        exist_user = Store.find(params[:store_id])

        #ストアレコードが存在するかの確認
        unless Store.find(params[:store_id])
            render json: {error: 'store record cant find'}, status: :not_found
            return
        end

        #登録するコネクションレコードの作成
        new_connection = current_api_v1_user.connections.new(store_id: params[:store_id])

        #コネクションレコードが無事に登録できたかの確認
        if new_connection.save
            render json: new_connection, status: :ok and return
        else 
            render json: {error: 'connection record cant registore'}, status: :bad_request  and return
        end
 
    end

    def destroy
        
        #コネクションレコードを参照   
        exist_connection = current_api_v1_user.connections.find_by_id(params[:id])

        #コネクションレコードが存在するかの確認
        if exist_connection.nil?
            render json: { error: 'record was not found'}, status: :not_found and return 
        end
        
        #コネクションレコードが実際に削除されたかの確認
        if exist_connection.destroy
            render json: {message: "success to delete record"}, status: :ok and return
        else 
            render json: {error: 'connection record cant destroy'}, status: :bad_request  and return
        end

    end

end
