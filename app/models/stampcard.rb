class Stampcard < ApplicationRecord
    
    #userとの関連付け
    belongs_to :user
    
    #stampacrd_contentとの関連付け
    belongs_to :stampcard_content
    has_many :shops, throw: :stampcard_contents
    
end
