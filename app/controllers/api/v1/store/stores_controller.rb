class Api::V1::Store::StoresController < ApplicationController

    # def index_connections

    #     exist_store = Store.find_by(stores_params)
    #     if exist_store.nil?
    #         render json: {error: "record was not exist"}, status: 404 and return
    #     else
    #         render json: exist_store.connections.to_a, status: 200 and return
    #     end
        
    # end

    private

    def stores_params
        params.permit(:id)
    end 

end