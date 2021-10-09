class Stampcard < ApplicationRecord
    
    #userとの関連付け
    belongs_to :user
    
end
