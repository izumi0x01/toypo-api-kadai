class Api::V1::ConnectionsController < ApplicationController
    
    def create 
        #ユーザのmeailと店舗のemailをもらうと、レコードを追加


        #レコードが存在すれば，スルー
        
        exist_connection = Connection.find_by(connections_params)
        if exist_connection.present?
            render json: {error: 'connection record was already registored'}, status: :bad_request and return
        end
        
        
        #ユーザとストアが存在するかを確認する
        
        unless User.find_by_id(params[:user_id])
            render json: {error: 'user record cant find'}, status: :not_found
            return
        end
        
        unless Store.find_by_id(params[:store_id])
            render json: {error: 'store record cant find'}, status: :not_found
            return
        end 
        
        # #token認証
        if api_v1_user_signed_in?
    
            client = request.headers['client']
            token = request.headers['access-token']

            unless User.find_by_id(params[:user_id]).valid_token?(token, client)
                render json: {error: 'user token not matched'}, status: :method_not_allowed and return
            end

        elsif api_v1_store_signed_in?

            client = request.headers['client']
            token = request.headers['access-token']

            unless Store.find_by_id(params[:store_id]).valid_token?(token, client)
                render json: {error: 'store token not matched'}, status: :method_not_allowed and return
            end
            
        else
            render json: {error: 'didnt log in'}, status: :method_not_allowed and return
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

        # #token認証
        if api_v1_user_signed_in?

            client = request.headers['client']
            token = request.headers['access-token']

            unless User.find_by_id(params[:user_id]).valid_token?(token, client)
                render json: {error: 'user token not matched'}, status: :method_not_allowed and return
            end

        elsif api_v1_store_signed_in?

            client = request.headers['client']
            token = request.headers['access-token']

            unless Store.find_by_id(params[:store_id]).valid_token?(token, client)
                render json: {error: 'store token not matched'}, status: :method_not_allowed and return
            end
            
        else
            render json: {error: 'didnt log in'}, status: :method_not_allowed and return
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

        # storeとuserのそれぞれの場合においてtoken認証が通っていれば，ユーザとストアのindexを返す

        # #token認証
        if api_v1_user_signed_in?
    
            client = request.headers['client']
            token = request.headers['access-token']

            connected_user = User.find_by_id(params[:user_id])
            if connected_user.valid_token?(token, client)
                render json: Connection.where(user_id: params[:user_id]), status: :ok and return 
            else
                render json: {error: 'user token not matched'}, status: :method_not_allowed and return
            end
            

        elsif api_v1_store_signed_in?

            client = request.headers['client']
            token = request.headers['access-token']

            connected_store = Store.find_by_id(params[:store_id])
            if connected_store.valid_token?(token, client)
                render json: Connection.where(store_id: params[:store_id]) , status: :ok and return 
            else
                render json: {error: 'store token not matched'}, status: :method_not_allowed and return
            end
            
        else
            render json: {error: 'didnt log in'}, status: :method_not_allowed and return
            return
        end

    end

    def show

        # #token認証
        if api_v1_user_signed_in?
    
            client = request.headers['client']
            token = request.headers['access-token']

            unless User.find_by_id(params[:user_id]).valid_token?(token, client)
                render json: {error: 'user token not matched'}, status: :method_not_allowed and return
            end

        elsif api_v1_store_signed_in?

            client = request.headers['client']
            token = request.headers['access-token']

            unless Store.find_by_id(params[:store_id]).valid_token?(token, client)
                render json: {error: 'store token not matched'}, status: :method_not_allowed and return
            end
            
        else
            render json: {error: 'didnt log in'}, status: :method_not_allowed and return
            return
        end

        #ユーザのemailと店舗のemailをもらうと、当該のレコードを照会
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

    def token_auth

    end

end
