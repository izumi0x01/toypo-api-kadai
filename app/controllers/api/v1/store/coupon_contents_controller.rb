class CouponContentsController < ApplicationController

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

        #クーポンコンテンツレコードが登録できているかの確認
        if exist_coupon_content.present?
            render json: {error: 'coupon_content was already registored'}, status: :bad_request and return
        end

        # クーポンコンテンツレコードの作成
        new_coupon_content = current_api_v1_store.coupon_contents.new(create_coupon_contents_params)

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
        if exist_coupon_content.nil?
            render json: {error: 'coupon_content was not exist'}, status: :bad_request and return
        end

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
        unless exist_coupon_content.present?
            render json: { error: 'coupon_content record not exist'}, status: :not_found and return 
        end

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
