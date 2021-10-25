require "date"

class  Api::V1::User::CouponsController < ApplicationController

    # いもくさいことをやめよう
    # スライド作ろう
    # couch if を作ろう
    # DB設計がまずいのでは

    before_action :authenticate_api_v1_user!

    def index
        
        #クーポンレコードを参照
        exist_coupons = current_api_v1_user.coupons

        #クーポンレコードの一覧をレスポンスに渡すことができたかどうかの確認
        if exist_coupons.present?
            render json: exist_coupons, status: :ok and return
        else
            render json: {error: "record was not exist"} , status: :not_found and return
        end

    end
    
    def show

        #クーポンレコードの参照
        extract_coupon = current_api_v1_user.coupons.find_by_id(params[:id])

        #クーポン情報が返せたかどうかの確認
        if extract_coupon.present?
            render json: extract_coupon, status: :ok and return
        else
            render json: {error: "record was not exist"}, status: :not_found and return
        end
        
    end

    def create

        #クーポンコンテンツレコードの参照
        extract_coupon_content = CouponContent.find_by_id(params[:coupon_content_id])

        #クーポンカードコンテンツレコードが存在するかどうかの確認 
        render json: {error: 'coupon_content record cant find'}, status: :not_found and return unless extract_coupon_content.present?

        #スタンプカードレコードの参照
        extract_stampcard = Stampcard.find_by_id(params[:stampcard_id])
        
        #スタンプカードレコードが存在するかどうかの確認 
        render json: {error: 'stampcard record cant find'}, status: :not_found and return unless extract_stampcard.present?
        
        #つながっているかの確認
        store_ids=[]
        current_api_v1_user.stores do |store|
            store_ids.append(store.id)
        end
        
        #つながっているかの確認
        if store_ids.include?(extract_coupon_content.store_id)
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end 


        #クーポン発行時にスタンプが所望の値に到達しているかの確認
        render json: {error: "Not enough stamps"}, status: :not_found and return if extract_coupon_content.required_stamp_count > extract_stampcard.stamp_count

        #クーポンレコードを作成
        new_coupon = current_api_v1_user.coupons.new(create_coupons_params)

        #有効期限を設定
        now = DateTime.now
        now += extract_coupon_content.valid_day
        new_coupon.expiration_date = now

        #スタンプカードレコードが登録できたかの確認
        if new_coupon.save 
            render json: new_coupon, status: :ok and return
        else 
            render json: {error: 'stampcard record cant registore'}, status: :bad_request and return
        end

    end

    def update

        #クーポンレコードの参照
        extract_coupon = current_api_v1_user.coupons.find_by_id(params[:id])

        #クーポンカードコンテンツレコードが存在するかどうかの確認 
        render json: {error: 'coupon_content record cant find'}, status: :not_found and return unless extract_coupon.present?

        #つながっているかの確認
        store_ids=[]
        current_api_v1_user.stores do |store|
            store_ids.append(store.id)
        end
        
        #つながっているかの確認
        if store_ids.include?(extract_coupon.coupon_content.store_id)
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end 
        
        #有効期限を設定
        extract_coupon.expiration_date += (params[:change_valid_day]).to_i.days

        if extract_coupon.expiration_date < DateTime.now
            render json: {error: "the date must be set after today"}, status: :not_found and return
        end

        #スタンプカードレコードを更新できたかの確認
        if extract_coupon.save
            render json: extract_coupon, status: :ok and return             
        else
            render json: {error: 'extract_coupon recored cant update'}, status: :bad_request and return
        end

    end  

    def destroy

        #クーポンレコードの参照
        extract_coupon = current_api_v1_user.coupons.find_by_id(params[:id])

        #クーポンカードコンテンツレコードが存在するかどうかの確認 
        render json: {error: 'coupon_content record cant find'}, status: :not_found and return unless extract_coupon.present?

        #つながっているかの確認
        store_ids=[]
        current_api_v1_user.stores do |store|
            store_ids.append(store.id)
        end
        
        #つながっているかの確認
        if store_ids.include?(extract_coupon.coupon_content.store_id)
            render json: {error: "this Stamp card record was not connected with store yet"}, status: :not_found and return
        end 

        #有効期限が切れていないかの確認
        if extract_coupon.expiration_date < DateTime.now
            render json: {error: "Cannot be used because the expiration date has expired"}, status: :not_found and return
        end

        #スタンプカードレコードが削除できたかの確認
        if extract_coupon.destroy
            render json: {message: "success to delete coupon record"}, status: :ok and return
        else 
            render json: {error: 'coupon record cant destroy'}, status: :bad_request  and return
        end

    end

    private

    def create_coupons_params
        params.permit(:coupon_content_id, :stampcard_id)
    end

    def update_coupons_params
        params.permit(:coupon_content_id, :change_valid_day)
    end
    
end
