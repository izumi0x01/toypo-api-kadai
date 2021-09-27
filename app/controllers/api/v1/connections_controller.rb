class Api::V1::ConnectionsController < ApplicationController
    
    def create 
        #ユーザのmeailと店舗のemailをもらうと、レコードを追加

        #レコードが存在すれば，スルー
        exist_connection = Connection.find_by(connections_params)
        if exist_connection.present?
            render json: {error: 'connection record was already registored'}, status: 422 and return
        end
        
        #レコードを作成
        new_connection = Connection.new(connections_params)

        unless Store.find_by_id(new_connection.store_id)
            render json: {error: 'store record cant find'}, status: 422 
            return
        end 

        unless User.find_by_id(new_connection.user_id)
            render json: {error: 'user record cant find'}, status: 422 
            return
        end

        if new_connection.save
            render json: new_connection, status: 200 and return
        else 
            render json: {error: 'connection record cant registore'}, status: 422  and return
        end
 
    end

    def destroy
        
        #ユーザのemailと店舗のemailをもらうと、当該のレコードを削除
        exist_connection = Connection.find_by(connections_params)

        unless Store.find_by_id(exist_connection.store_id)
            render json: {error: 'store record cant find'}, status: 422 
            return
        end 

        unless User.find_by_id(exist_connection.user_id)
            render json: {error: 'user record cant find'}, status: 422 
            return
        end

        if exist_connection.present?
            #レコードが登録されていたならば既存のレコードを削除
            exist_connection.destroy
            render json: exist_connection, status: 200 and return 
        else
            render json: { error: 'record was not found'}, status: 422 and return 
        end
    end


    def connections_params
        params.permit(:user_id, :store_id)
    end

end
