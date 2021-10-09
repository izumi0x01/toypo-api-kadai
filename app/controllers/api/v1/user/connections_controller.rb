class Api::V1::User::ConnectionsController < ApplicationController
    
    before_action :authenticate_api_v1_user!

    #ユーザのidをもらうとレコードを作成
    def create 

        #レコードが存在するか        
        exist_connection = current_api_v1_user.connections.find_by(connection_users_params)
        if exist_connection.present?
            render json: {error: 'connection record was already registored'}, status: :bad_request and return
        end
        
        #ユーザが存在するか
        unless Store.find(params[:store_id])
            render json: {error: 'store record cant find'}, status: :not_found
            return
        end 

        #device_token_authを使ってレコードを作成
        new_connection = current_api_v1_user.connections.new(connection_users_params)

        #レコードの登録
        if new_connection.save
            render json: new_connection, status: :ok and return
        else 
            render json: {error: 'connection record cant registore'}, status: :bad_request  and return
        end
 
    end

    #ユーザのidをもらうと、当該のレコードを削除
    def destroy
        
        exist_connection = current_api_v1_user.connections.find_by(connection_users_params)

        if exist_connection.present?
            #レコードが登録されていたならば既存のレコードを削除
            exist_connection.destroy
            render json: exist_connection, status: :ok and return 
        else
            render json: { error: 'record was not found'}, status: :not_found and return 
        end

    end

    #店舗のidをもらうと，つながっている全てのレコードを返す
    def index

        exist_connections = current_api_v1_user.connections

        if exist_connections.present?
            render json: exist_connections, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end

    end

    #店舗のidをもらうと，ユーザとつながっている店舗のレコードを返す
    def show

        exist_connection = current_api_v1_user.connections.find_by(connection_users_params)

        if exist_connection.present?
            render json: exist_connection, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end

    end
    
    private

    def connection_users_params
        params.permit(:store_id)
    end

end