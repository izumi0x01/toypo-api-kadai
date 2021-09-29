class Api::V1::ConnectionsController < ApplicationController
    
    before_action :authenticate_user!

    def create 
        #ユーザのmeailと店舗のemailをもらうと、レコードを追加

        #レコードが存在すれば，スルー
        exist_connection = Connection.find_by(connections_params)
        if exist_connection.present?
            render json: {error: 'connection record was already registored'}, status: :bad_request and return
        end
        
        
        unless Store.find_by_id(exist_connection.store_id)
            render json: {error: 'store record cant find'}, status: :not_found
            return
        end 
        
        unless User.find_by_id(exist_connection.user_id)
            render json: {error: 'user record cant find'}, status: :not_found
            return
        end

        #レコードを作成
        new_connection = Connection.new(connections_params)

        if new_connection.save
            render json: new_connection, status: :ok and return
        else 
            render json: {error: 'connection record cant registore'}, status: :bad_request  and return
        end
 
    end

    def destroy
        
        #ユーザのemailと店舗のemailをもらうと、当該のレコードを削除
        exist_connection = Connection.find_by(connections_params)

        unless Store.find_by_id(exist_connection.store_id)
            render json: {error: 'store record cant find'}, status: :not_found
            return
        end 

        unless User.find_by_id(exist_connection.user_id)
            render json: {error: 'user record cant find'}, status: :not_found
            return
        end

        if exist_connection.present?
            #レコードが登録されていたならば既存のレコードを削除
            exist_connection.destroy
            render json: exist_connection, status: :ok and return 
        else
            render json: { error: 'record was not found'}, status: :not_found and return 
        end
    end

    def index

    end

    def show

        #ユーザのemailと店舗のemailをもらうと、当該のレコードを削除
        exist_connection = Connection.find_by(connections_params)

        if exist_connection.present?
            render json: exist_connection, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end

    end
    
    private

    def connections_params
        params.permit(:user_id, :store_id)
    end

end
