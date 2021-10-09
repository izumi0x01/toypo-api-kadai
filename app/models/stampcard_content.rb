class StampcardContent < ActiveRecord::Base
    
    #shopとの関連付け
    belongs_to :store

    #stampcardとの関連付け
    has_many :stampcards, dependent: :destroy
    
end
