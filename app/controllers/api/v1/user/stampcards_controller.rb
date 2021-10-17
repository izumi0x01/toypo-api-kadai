class Api::V1::User::StampcardsController < ApplicationController

    before_action :authenticate_api_v1_user!

    def index
        
        #スタンプカードレコードを参照
        extract_stampcards = current_api_v1_user.stampcards

        #スタンプカードレコードが存在するかの確認
        unless extract_stampcards.present?
            render json: {error: "stampcard records were not exist"}, status: :not_found and return
        end

        #つながりのレコードの一覧を参照
        extract_connections = current_api_v1_user.connections

        # 変数の初期化
        connected_stampcards = []

        extract_stampcards.each do |extract_stampcard|

            #スタンプカードが参照しているスタンプカードコンテントの店舗IDを取得
            store_id_depend_with_stampcard_content = StampcardContent.find_by_id(extract_stampcard.stampcard_content_id).store_id
            
            # 繋がりのレコードの店舗IDと同じとなる，スタンプカードコンテントのレコードを取得
            associated_connection_with_stampcard_content = extract_connections.find_by(store_id: store_id_depend_with_stampcard_content)

            unless associated_connection_with_stampcard_content.present?
                next 
            end

            connected_stampcards.append(extract_stampcard)
            
        end

        #繋がっている店舗が発行しているスタンプカードかどうかの確認
        if connected_stampcards.present?
            render json: connected_stampcards, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end

    end
    
    def show

        #スタンプカードレコードを参照
        extract_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        #スタンプカードレコードが存在するかの確認
        unless extract_stampcard.present?
            render json: {error: "stampcard record was not exist"}, status: :not_found and return
        end

        #つながりのレコードの一覧を参照
        extract_connections = current_api_v1_user.connections

        #スタンプカードが参照しているスタンプカードコンテントの店舗IDを取得
        store_id_depend_with_stampcard_content = StampcardContent.find_by_id(extract_stampcard.stampcard_content_id).store_id
        
        # 繋がりのレコードの店舗IDと同じとなる，スタンプカードコンテントのレコードを取得
        associated_connection_with_stampcard_content = extract_connections.find_by(store_id: store_id_depend_with_stampcard_content)

        #繋がっている店舗が発行しているスタンプカードかどうかの確認
        unless  associated_connection_with_stampcard_content.present?
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end

        #変数の入れ替え
        connected_stampcard = extract_stampcard      

        #繋がっている店舗が発行しているスタンプカードかどうかの確認
        if connected_stampcard.present?
            render json: connected_stampcard, status: :ok and return
        else
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end
        
    end

    def create

        #スタンプカードコンテンツレコードの参照
        extract_stampcard_content = StampcardContent.find_by_id(params[:stampcard_content_id])

        #スタンプカードコンテンツレコードが存在するかどうかの確認
        unless extract_stampcard_content.present?
            render json: {error: 'stampcard_content record cant find'}, status: :not_found
            return
        end 

        #つながりのレコードの一覧を参照
        extract_connections = current_api_v1_user.connections

        # スタンプカードが参照している店舗IDを参照
        store_id_depend_with_stampcard_content = StampcardContent.find_by_id(params[:stampcard_content_id]).store_id

        #繋がりのレコードの店舗IDと同じとなる，スタンプカードコンテントのレコードを取得
        associated_connection_with_stampcard_content = extract_connections.find_by(store_id: store_id_depend_with_stampcard_content)

        #繋がっている店舗が発行しているスタンプカードかどうかの確認
        unless  associated_connection_with_stampcard_content.present?
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end

        #スタンプカードレコードを参照
        exist_stampcard = current_api_v1_user.stampcards.find_by(create_stampcards_params)

        #存在するスタンプカードのスタンプカードコンテンツidが重複すれば，はねる
        if exist_stampcard.present?
            render json: {error: 'this kind of stampcard was already registored'}, status: :bad_request and return
        end

        #スタンプカードレコードを作成
        new_stampcard = current_api_v1_user.stampcards.new(create_stampcards_params)
        new_stampcard.stamp_count = 0

        #スタンプカードレコードが登録できたかの確認
        if new_stampcard.save
            render json: new_stampcard, status: :ok and return
        else 
            render json: {error: 'stampcard record cant registore'}, status: :bad_request and return
        end

    end

    def update

        #スタンプカードレコードを参照
        extract_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        #スタンプカードレコードが存在するかの確認
        unless extract_stampcard.present?
            render json: {error: "stampcard record was not exist"}, status: :not_found and return
        end

        #つながりのレコードの一覧を参照
        extract_connections = current_api_v1_user.connections

        #スタンプカードが参照しているスタンプカードコンテントの店舗IDを取得
        store_id_depend_with_stampcard_content = StampcardContent.find_by_id(extract_stampcard.stampcard_content_id).store_id
        
        # 繋がりのレコードの店舗IDと同じとなる，スタンプカードコンテントのレコードを取得
        associated_connection_with_stampcard_content = extract_connections.find_by(store_id: store_id_depend_with_stampcard_content)

        #繋がっている店舗が発行しているスタンプカードかどうかの確認
        unless  associated_connection_with_stampcard_content.present?
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end

        #変数の入れ替え
        connected_stampcard = extract_stampcard

        #スタンプカードにスタンプを押す
        connected_stampcard.stamp_count += connected_stampcard.stampcard_content.add_stamp_count

        #スタンプが上限数を超えていないかの確認
        if connected_stampcard.stamp_count > connected_stampcard.stampcard_content.max_stamp_count
            render json: {error: 'stamp maximum count has been exceeded'}, status: :bad_request  and return
        end
        
        #スタンプカードレコードを更新できたかの確認
        if connected_stampcard.save
            render json: connected_stampcard, status: :ok and return             
        else
            render json: {error: 'stampcard recored cant update'}, status: :bad_request and return
        end

    end  

    def destroy

        #スタンプカードレコードを参照
        extract_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        #スタンプカードレコードが存在するかの確認
        unless extract_stampcard.present?
            render json: {error: "stampcard record was not exist"}, status: :not_found and return
        end

        #つながりのレコードの一覧を参照
        extract_connections = current_api_v1_user.connections

        #スタンプカードが参照しているスタンプカードコンテントの店舗IDを取得
        store_id_depend_with_stampcard_content = StampcardContent.find_by_id(extract_stampcard.stampcard_content_id).store_id
        
        # 繋がりのレコードの店舗IDと同じとなる，スタンプカードコンテントのレコードを取得
        associated_connection_with_stampcard_content = extract_connections.find_by(store_id: store_id_depend_with_stampcard_content)

        #繋がっている店舗が発行しているスタンプカードかどうかの確認
        unless  associated_connection_with_stampcard_content.present?
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end

        #変数の入れ替え
        connected_stampcard = extract_stampcard

        #スタンプカードレコードが削除できたかの確認
        if connected_stampcard.destroy
            render json: {message: "success to delete stampcard record"}, status: :ok and return
        else 
            render json: {error: 'stampcard record cant destroy'}, status: :bad_request  and return
        end

    end

    private

    def create_stampcards_params
        params.permit(:stampcard_content_id)
    end
    
end