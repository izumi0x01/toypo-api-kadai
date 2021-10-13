class Api::V1::StampcardContentsController < ApplicationController

    before_action :authenticate_api_v1_store!

    def create

        exist_stampcard_content = current_api_v1_store.stampcard_content

        if exist_stampcard_content.present?
            render json: {error: 'stampcard_content was already registored'}, status: :bad_request and return
        end

        new_stampcard_content = current_api_v1_store.build_stampcard_content(create_stampcard_contents_params)

        #レコードの登録
        if new_stampcard_content.save
            render json: new_stampcard_content, status: :ok and return
        else 
            render json: {error: 'stampcard_content cant registore'}, status: :bad_request  and return
        end

    end

    def update

        exist_stampcard_content = current_api_v1_store.stampcard_content

        if exist_stampcard_content.nil?
            render json: {error: 'stampcard_content was not exist'}, status: :bad_request and return
        end

        #レコードの登録
        if exist_stampcard_content.update(update_stampcard_contents_params)
            render json: exist_stampcard_content, status: :ok and return
        else 
            render json: {error: 'stampcard_content cant update'}, status: :bad_request  and return
        end

    end

    def destroy

        exist_stampcard_content = current_api_v1_store.stampcard_content

        if exist_stampcard_content.present?
            #レコードが登録されていたならば既存のレコードを削除
            exist_stampcard_content.destroy
            render json: { message: 'success to delete record'}, status: :ok and return 
        else
            render json: { error: 'stampcard_content not exist'}, status: :not_found and return 
        end

    end

    def show
        exist_stampcard = current_api_v1_store.stampcard_content

        if exist_stampcard.present?
            render json: exist_stampcard, status: :ok and return
        else
            render json: {error: "stampcard_content was not exist"}, status: :not_found and return
        end
    end

    private

    def create_stampcard_contents_params
        params.permit(:max_stamp_count)
    end

    def update_stampcard_contents_params
        params.permit(:max_stamp_count)
    end

end
