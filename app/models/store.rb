class Store < ApplicationRecord

    # has_secure_password
    # has_secure_token
    
    validates :store_name, presence: true
    validates :hashed_password, uniqueness: true
    validates :email, {presence: true, uniqueness: true}

    # 一般的なdef メソッド()では書込み・読込みどちらも可能
    # def メソッド名=()では書込みオンリー
    def password=(raw_password)
        if raw_password.kind_of?(String)
            self.hashed_password = BCrypt::Password.create(raw_password)            
        elsif raw_password.nil?
            self.hashed_password = nil            
        end
    end

end
