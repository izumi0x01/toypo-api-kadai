class Api::V1::StampcardsController < ApplicationController

    before_action :authenticate_api_v1_user!

    def create

        #stampcard_contentが存在するか
        unless StampcardContent.find_by_id(stampcard_content_id: params[:stampcard_content_id])
            render json: {error: 'stampcard_content cant find'}, status: :not_found
            return
        end 

        exist_stampcards = current_api_v1_user.stampcards
        
        # 存在するスタンプカードのスタンプカードコンテンツidが重複すれば，はねる
        if exist_stampcards.find_by(stampcard_content_id: params[:stampcard_content_id])
            render json: {error: 'this kind of stampcard was already registored'}, status: :bad_request and return
        end

        new_stampcard = current_api_v1_user.stampcards.new(stampcard_content_id: params[:stampcard_content_id], stamp_count: 0)

        #レコードの登録
        if new_stampcard.save
            render json: new_stampcard, status: :ok and return
        else 
            render json: {error: 'stampcard cant registore'}, status: :bad_request  and return
        end

    end


    def update

        exist_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        unless exist_stampcard.present?
            render json: { error: 'stampcard was not found'}, status: :not_found and return 
        end

        
        #スタンプカードが存在した場合に，スタンプを一つ追加する．
        exist_stampcard.stamp_count += 1

        #スタンプが上限数を超えると保存ができない
        if exist_stampcard.stamp_count > exist_stampcard.stampcard_content.max_stamp_count
            render json: {error: 'stamp maximum count has been exceeded'}, status: :bad_request  and return
        end
        
        if exist_stampcard.save
            render json: exist_stampcard, status: :ok and return             
        else
            render json: {error: 'stampcard cant update'}, status: :bad_request  and return
        end

    end  

    def destroy

        exist_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        if exist_stampcard.present?
            #レコードが登録されていたならば既存のレコードを削除
            exist_stampcard.destroy
            render json: { message: 'success to delete record'} , status: :ok and return 
        else
            render json: { error: 'stampcard was not found'}, status: :not_found and return 
        end

    end

    # ok
    def index

        exist_stampcards = current_api_v1_user.stampcards.find_by(stampcard_content_id: params[:stampcard_content_id])

        if exist_stampcards.present?
            render json: exist_stampcards, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end

    end

    
    def show

        exist_stampcard = current_api_v1_user.stampcards.find_by_id(params[:id])

        if exist_stampcard.present?
            render json: exist_stampcard, status: :ok and return
        else
            render json: {error: "stampcard record was not exist"}, status: :not_found and return
        end
        
    end

    private

    def stampcards_create_params
        params.permit(:stampcard_content_id)
    end
    
    def stampcards_update_params
        params.permit(:stampcard_content_id)
    end
    
end


    

