class Api::V1::Store::RegistrationsController < DeviseTokenAuth::RegistrationsController



    private

    def sign_up_params
        params.permit(:email,:name,:address,:password, :password_confirmation)
    end

    def account_update_params
        params.permit(:email,:name,:address,:password)
    end



end