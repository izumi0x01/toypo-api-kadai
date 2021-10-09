class Api::V1::User::RegistrationsController < DeviseTokenAuth::RegistrationsController

    private

    def sign_up_params
        params.permit(:email,:name,:password, :password_confirmation)
    end

    def account_update_params
        params.permit(:email,:name,:password)
    end

end