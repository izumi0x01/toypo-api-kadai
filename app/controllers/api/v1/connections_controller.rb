class Api::V1::ConnectionsController < ApplicationController
   
    # 繋がりを設定する
    before_action :find_Connection_record
    
    def create 
        #ユーザのmeailと店舗のemailをもらうと、レコードを追加

        if connection
            render json:{ error: 'record was already registored'}, status: 422
        else
            #レコードが登録されていなければ新たにレコードを追加
            Connection.create(user_id: user.id,store_id: store.id)
        end
 
    end

    def delete 
        #ユーザのemailと店舗のemailをもらうと、当該のレコードを削除

        if connection
            #レコードが登録されていたならば既存のレコードを削除
            Connection.find(id: connection.id).destroy
        else
            render json:{ error: 'record was not found'}, status: 422
        end
    end

    def show
        #ユーザのemailを渡すと、登録した全ての店舗の情報（メアド、名前、住所）を返す。
        if params[:store_email].empty?
            show_User_records_in_Connection_table
        elsif params[:user_email].empty?
            show_Store_records_in_Connection_table
        end
    end

    private


    def find_User_record_in_User_table
        #ユーザのメアドと一致するuserテーブルのレコードを取得
        user = User.find_by(email: params[:user_email]) 
        unless user 
            #もしユーザ情報が存在しなければ
            render json: { error: 'Faild find user'}, status: 422
            return
        end
    end

    def find_Store_record_in_Store_table
        #店舗のメアドと一致するstoreテーブルのレコードを取得
        store = Store.find_by(email: params[:store_email])
        unless store
            #もし店舗情報が存在しなければ
            render json: { error: 'Faild find store'}, status: 422
            return
        end
    end

    
    def find_Connection_record
        find_User_record_in_User_table
        find_Store_record_in_Store_table
        #ユーザと店舗のレコードが存在した場合に、つながるのレコードを取得
        connection = Connection.where(user_id: user.id).where(store_id: store.id)
    end

    def show_User_records_in_Connection_table
        user_records = Connection.where(user_id: user.id) 
    end

    def show_Store_records_in_Connection_table
         store_records = Connection.where(store_id: store.id) 
    end

    def connections_params
        params.permit(:user_email,:store_email)
    end

end
