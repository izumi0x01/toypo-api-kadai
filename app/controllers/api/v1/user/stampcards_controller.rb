class Api::V1::User::StampcardsController < ApplicationController

    before_action :authenticate_api_v1_user!

    def index

        #スタンプカードレコードの一覧を参照
        exist_stampcards = current_api_v1_user.stampcards

        #スタンプカードレコードの一覧が存在すればレコード情報を返す
        if exist_stampcards.present?
            render json: exist_stampcards, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end

    end
    
    def show

        #スタンプカードレコードを参照
        exist_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        #スタンプカードが存在すれば情報を返す
        if exist_stampcard.present?
            render json: exist_stampcard, status: :ok and return
        else
            render json: {error: "stampcard record was not exist"}, status: :not_found and return
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
        exist_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        #スタンプカードレコードが存在するかの確認
        unless exist_stampcard.present?
            render json: { error: 'stampcard record was not found'}, status: :not_found and return 
        end

        #スタンプカードにスタンプを押す
        exist_stampcard.stamp_count += exist_stampcard.stampcard_content.add_stamp_count

        #スタンプが上限数を超えていないかの確認
        if exist_stampcard.stamp_count > exist_stampcard.stampcard_content.max_stamp_count
            render json: {error: 'stamp maximum count has been exceeded'}, status: :bad_request  and return
        end
        
        #スタンプカードレコードを更新できたかの確認
        if exist_stampcard.save
            render json: exist_stampcard, status: :ok and return             
        else
            render json: {error: 'stampcard recored cant update'}, status: :bad_request  and return
        end

    end  

    def destroy

        #スタンプカードレコードを参照
        exist_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        #スタンプカードレコードが登録されているかの確認
        if exist_stampcard.present?
            render json: { error: 'stampcard record was not found'}, status: :not_found and return 
        end

        #スタンプカードレコードが削除できたかの確認
        if exist_stampcard.destroy
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