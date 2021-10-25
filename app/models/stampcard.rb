class Stampcard < ApplicationRecord
    
    #userとの関連付け
    belongs_to :user

    #stampcardcontentsとの関連付け
    belongs_to :stampcard_content

    #couponとの関連付け
    has_many :coupons,  dependent: :destroy

end