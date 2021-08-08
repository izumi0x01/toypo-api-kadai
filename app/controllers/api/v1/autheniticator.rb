class Api::V1::Autheniticator
    def initialize(store)
        @store = store
    end

    def autheniticate(raw_password)    
        #storeインスタンスが設定されており、パスワードが有効で、パスワードが正し時にTrueを返す
        @store && @store.hashed_password &&  BCrypt::Password.new(@store.hashed_password) == raw_password
    end
end