class Api::V1::User::StampcardsController < ApplicationController

    before_action :authenticate_api_v1_user!

    def index
        
        #スタンプカードレコードを参照
        extract_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        #スタンプカードレコードが存在するかの確認
        unless extract_stampcard.present?
            render json: {error: "stampcard record was not exist"}, status: :not_found and return
        end

        #つながりのレコードの一覧を参照
        extract_connections = current_api_v1_user.connections

        #繋がりのレコードの中で，スタンプカードが参照している店舗と同じレコードを参照
        connected_stampcard = extract_connections.where(user_id: extract_stampcard.stampcard_contents.store_id)  

        #繋がっている店舗が発行しているスタンプカードかどうかの確認
        if exist_stampcards.present?
            render json: exist_stampcards, status: :ok and return
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

        #繋がりのレコードの中で，スタンプカードが参照している店舗と同じレコードを参照
        connected_stampcard = extract_connections.find_by(user_id: extract_stampcard.stampcard_contents.store_id)           

        #繋がっている店舗が発行しているスタンプカードかどうかの確認
        if connected_stampcard.present?
            render json: connected_stampcard, status: :ok and return
        else
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end
        
    end

    def create

        #スタンプカードコンテンツレコードの参照
        exist_stampcard = StampcardContent.find_by_id(stampcards_create_params)

        #スタンプカードレコードが存在するかどうかの確認
        unless exist_stampcard
            render json: {error: 'stampcard_content record cant find'}, status: :not_found
            return
        end 

        #スタンプカードレコードを参照
        exist_stampcards = current_api_v1_user.stampcards
        
        #存在するスタンプカードのスタンプカードコンテンツidが重複すれば，はねる
        if exist_stampcards.find_by(stampcards_create_params)
            render json: {error: 'this kind of stampcard was already registored'}, status: :bad_request and return
        end

        #つながりのレコードの一覧を参照
        extract_connections = current_api_v1_user.connections

        #繋がりのレコードの中で，スタンプカードが参照している店舗と同じレコードを参照
        connected_stampcard = extract_connections.find_by(user_id: extract_stampcard.stampcard_contents.store_id)

        #繋がっている店舗が発行しているスタンプカードかどうかの確認
        unless connected_stampcard.present?
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end

        #スタンプカードレコードを作成
        new_stampcard = current_api_v1_user.stampcards.new(stampcards_create_params)
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

        #繋がりのレコードの中で，スタンプカードが参照している店舗と同じレコードを参照
        connected_stampcard = extract_connections.find_by(user_id: extract_stampcard.stampcard_contents.store_id)           
        
        # 取り出したスタンプカードが繋がっている店舗のものかどうかの確認
        unless connected_stampcard.present?
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end

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

        #繋がりのレコードの中で，スタンプカードが参照している店舗と同じレコードを参照
        connected_stampcard = extract_connections.find_by(user_id: extract_stampcard.stampcard_contents.store_id)           
        
        # 取り出したスタンプカードが繋がっている店舗のものかどうかの確認
        unless connected_stampcard.present?
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end

        #スタンプカードレコードが削除できたかの確認
        if extract_stampcard.destroy
            render json: {message: "success to delete stampcard record"}, status: :ok and return
        else 
            render json: {error: 'stampcard record cant destroy'}, status: :bad_request  and return
        end

    end

    private

    def stampcards_create_params
        params.permit(:stampcard_content_id)
    end
    
end