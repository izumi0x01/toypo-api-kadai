class Api::V1::Store::StampcardContentsController < ApplicationController

    before_action :authenticate_api_v1_store!

    def show
        
        #スタンプカードコンテンツレコードの参照
        exist_stampcard_content = current_api_v1_store.stampcard_content

        #スタンプカードコンテンツレコードが存在すれば，レコードをレスポンスに渡す
        if exist_stampcard_content.present?
            render json: exist_stampcard_content, status: :ok and return
        else
            render json: {error: "stampcard_content was not exist"}, status: :not_found and return
        end
    end 

    def create

        #スタンプカードコンテンツレコードの参照
        exist_stampcard_content = current_api_v1_store.stampcard_content

        #スタンプカードコンテンツレコードが登録できているかの確認
        if exist_stampcard_content.present?
            render json: {error: 'stampcard_content was already registored'}, status: :bad_request and return
        end

        #スタンプカードコンテンツレコードの作成
        new_stampcard_content = current_api_v1_store.build_stampcard_content(create_stampcard_contents_params)

        #スタンプカードコンテンツレコードが登録できたかの確認
        if new_stampcard_content.save
            render json: new_stampcard_content, status: :ok and return
        else 
            render json: {error: 'stampcard_content cant registore'}, status: :bad_request  and return
        end

    end

    def update

        # スタンプカードコンテントレコードの参照
        exist_stampcard_content = current_api_v1_store.stampcard_content

        # スタンプカードコンテンツレコードが存在するかどうかの確認
        if exist_stampcard_content.nil?
            render json: {error: 'stampcard_content was not exist'}, status: :bad_request and return
        end

        # スタンプカードコンテンツレコードが更新できたかの確認
        if exist_stampcard_content.update(update_stampcard_contents_params)
            render json: exist_stampcard_content, status: :ok and return
        else 
            render json: {error: 'stampcard_content cant update'}, status: :bad_request  and return
        end

    end

    def destroy

        # スタンプカードコンテンツレコードを参照
        exist_stampcard_content = current_api_v1_store.stampcard_content

        # スタンプカードコンテンツレコードが存在するかの確認
        unless exist_stampcard_content.present?
            render json: { error: 'stampcard_content record not exist'}, status: :not_found and return 
        end

        #スタンプカードコンテンツレコードが削除できたかの確認
        if exist_stampcard_content.destroy
            render json: {message: "success to delete stampcard_contents record"}, status: :ok and return
        else  
            render json: {error: 'stampcard_contents record cant destroy'}, status: :bad_request  and return
        end

    end

    private

    def create_stampcard_contents_params
        params.permit(:max_stamp_count, :add_stamp_count)
    end

    def update_stampcard_contents_params
        params.permit(:max_stamp_count, :add_stamp_count)
    end

end
