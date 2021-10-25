class  Api::V1::Store::CouponContentsController < ApplicationController

    before_action :authenticate_api_v1_store!

    def index

        #クーポンコンテンツレコードの一覧の参照
        exist_coupon_contents = current_api_v1_store.coupon_contents

        #クーポンコンテンツレコードが存在すれば，レコードの一覧をレスポンスに渡す
        if exist_coupon_contents.present?
            render json: exist_coupon_contents, status: :ok and return
        else
            render json: {error: "coupon_content was not exist"}, status: :not_found and return
        end

    end

    def show
        
        #クーポンコンテンツレコードの参照
        exist_coupon_content = current_api_v1_store.coupon_contents.find_by_id(params[:id])

        #クーポンコンテンツレコードが存在すれば，レコードをレスポンスに渡す
        if exist_coupon_content.present?
            render json: exist_coupon_content, status: :ok and return
        else
            render json: {error: "coupon_content was not exist"}, status: :not_found and return
        end
    end 

    def create

        #クーポンコンテンツレコードの参照
        exist_coupon_content = current_api_v1_store.coupon_contents.find_by(store_id: params[:store_id])

        #クーポンコンテンツレコードが登録されているかの確認
        render json: {error: 'coupon_content was already registored'}, status: :bad_request and return if exist_coupon_content.present?

        #スタンプカードコンテンツレコードの参照
        exist_stampcard_content = current_api_v1_store.stampcard_content

        #スタンプカードコンテンツレコードが登録されているかの確認
        render json: {error: 'stampcard_content was not registored'}, status: :bad_request and return unless exist_stampcard_content.present?

        # クーポンコンテンツレコードの作成
        new_coupon_content = current_api_v1_store.coupon_contents.new(create_coupon_contents_params)
        new_coupon_content.stampcard_content_id = current_api_v1_store.stampcard_content.id

        # クーポン発行時のスタンプ数がスタンプカードコンテンツのスタンプ数の上限をこえていないかの確認
        if exist_stampcard_content.max_stamp_count < new_coupon_content.required_stamp_count
            render json: {error: 'The number of stamps when issuing a coupon is incorrect'}, status: :bad_request and return
        end

        #クーポンコンテンツレコードが登録できたかの確認
        if new_coupon_content.save
            render json: new_coupon_content, status: :ok and return
        else 
            render json: {error: 'coupon_content cant registore'}, status: :bad_request  and return
        end

    end

    def update

        # クーポンコンテントレコードの参照
        exist_coupon_content = current_api_v1_store.coupon_contents.find_by_id(params[:id])

        # クーポンコンテンツレコードが存在するかどうかの確認
        render json: {error: 'coupon_content was not exist'}, status: :bad_request and return unless exist_coupon_content.present?

        # クーポンコンテンツレコードが更新できたかの確認
        if exist_coupon_content.update(update_coupon_contents_params)
            render json: exist_coupon_content, status: :ok and return
        else 
            render json: {error: 'coupon_content cant update'}, status: :bad_request  and return
        end

    end

    def destroy

        # クーポンコンテンツレコードを参照
        exist_coupon_content = current_api_v1_store.coupon_contents.find_by_id(params[:id])

        # クーポンコンテンツレコードが存在するかの確認
        render json: { error: 'coupon_content record not exist'}, status: :not_found and return unless exist_coupon_content.present?

        # クーポンコンテンツレコードが削除できたかの確認
        if exist_coupon_content.destroy
            render json: {message: "success to delete coupon_contents record"}, status: :ok and return
        else  
            render json: {error: 'coupon_contents record cant destroy'}, status: :bad_request  and return
        end

    end

    private

    def create_coupon_contents_params
        params.permit(:name, :required_stamp_count, :valid_day)
    end

    def update_coupon_contents_params
        params.permit(:name, :required_stamp_count, :valid_day)
    end
    
end
