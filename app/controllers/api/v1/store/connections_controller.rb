class Api::V1::Store::ConnectionsController < ApplicationController
    

    #やること：
    #.present?やnil?の書き方を統一する．ー＞書き方を校正１
    #connectionしたうえで，各メソッドが動く，ことを確認する．３
    #stampcardを同時に発行ができるようにDBの設計を見直す．２
    #空白行などが統一されているかを確認する．4
    #余裕があればstlongparameterの書き方を見直す．

    before_action :authenticate_api_v1_store!

    def create 

        #既に存在するコネクションレコードを参照
        exist_connection = current_api_v1_store.connections.find_by(user_id: params[:user_id])

        #コネクションレコードが存在するかの確認
        if exist_connection.present?
            render json: {error: 'connection record was already registored'}, status: :bad_request and return
        end
        
        #ストアレコードを参照
        exist_user = User.find(params[:user_id])

        #ストアレコードが存在するかの確認
        unless exist_user
            render json: {error: 'user record cant find'}, status: :not_found
            return
        end 
        
        #新たに登録するコネクションレコードの作成
        new_connection = current_api_v1_store.connections.new(user_id: params[:user_id])

        #コネクションレコードが無事に登録できたかの確認
        if new_connection.save
            render json: new_connection, status: :ok and return
        else 
            render json: {error: 'connection record cant registore'}, status: :bad_request  and return
        end

    end

    def destroy
        
        #既に存在するコネクションレコードを参照   
        exist_connection = current_api_v1_store.connections.find_by_id(params[:id])

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

    def index

        #既に存在するコネクションレコードの一覧を参照
        exist_connections = current_api_v1_store.connections

        #コネクションレコードの一覧をレスポンスに渡すことができたかどうかの確認
        if exist_connections.present?
            render json: exist_connections, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end

    end

    def show

        #既に存在するコネクションレコードを参照
        exist_connection = current_api_v1_store.connections.find_by_id(params[:id])

        #コネクションレコードをレスポンスに渡すことができたかどうかの確認
        if exist_connection.present?
            render json: exist_connection, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end
        
    end

end
