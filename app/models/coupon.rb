class Coupon < ApplicationRecord

    #userとの関連付け
    belongs_to :user
    
    #couponcontentsとの関連付け
    belongs_to :coupon_content

end
