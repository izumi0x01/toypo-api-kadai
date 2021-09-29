class Api::V1::StampcardsController < ApplicationController

    def create
        exist_stampcard = Stampcard.find_by(stampcards_params)
        if exist_stampcard.present?
            render json: {error: 'stampcard record was already registored'}, status: 404 and return
        end

        new_stampcard = Stampcard.new(stampcards_params.merge(stamp_count: 0))
        if new_stampcard.save
            render json: new_stampcard, status: 200 and return
        else    
            render json: {error: 'cant regist stampcard'}, status: 404 and return
        end
    end 

    def update
        exist_stampcard = Stampcard.find_by(user_id: stampcards_params.user_id)
    end 

    def stamp
        currente_stampcount = Stampcard.find_by(user_id: stampcards_params.user_id).stamp_count
        
    end 

    private

    def stampcards_params
        params.permit(:user_id, :stampcard_content_id)
    end
end
