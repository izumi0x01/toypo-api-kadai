class CouponContent < ApplicationRecord

        #storeとの関連付け
        belongs_to :store

        #couponとの関連付け
        has_many :coupons

        #storeとの関連付け
        belongs_to :stampcard_content

end
