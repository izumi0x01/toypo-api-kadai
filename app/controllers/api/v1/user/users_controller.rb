class Api::V1::User::UsersController < ApplicationController

    # def index_connections

    #     exist_user = User.find_by(users_params)
    #     if exist_user.nil?
    #         render json: {error: "record was not exist"}, status: 404 and return
    #     else
    #         render json: exist_user.connections.to_a, status: 200 and return
    #     end
        
    # end

    private

    def users_params
        params.permit(:id)
    end 

end