class StampcardContent < ApplicationRecord
    
    #shopとの関連付け
    belongs_to :store

    #stampcardとの関連付け
    has_many :stampcards, :destroy
    
end
