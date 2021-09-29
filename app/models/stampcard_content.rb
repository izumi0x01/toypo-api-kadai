class StampcardContent < ApplicationRecord
    
    #stampcardとの関連付け
    has_many :stampcards, dependent: :destroy
    has_many :users, throw: :stampcards

    #shopとの関連付け
    belongs_to :shop
end
