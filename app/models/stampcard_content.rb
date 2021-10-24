class StampcardContent < ActiveRecord::Base
    
    #shopとの関連付け
    belongs_to :store

    #stampcardとの関連付け
    has_many :stampcards, dependent: :destroy

    #coupon_contentとの関連付け
    has_many :coupon_contents, dependent: :destroy
    
end
