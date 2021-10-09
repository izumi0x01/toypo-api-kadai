class Api::V1::StampcardsController < ApplicationController

    # def create

    #     exist_stampcard = Stampcard.find_by(user_id: stampcards_params.user_id)
    #     if exist_stampcard.present?
    #         render json: {error: 'stampcard record was already registored'}, status: 404 and return
    #     end

    #     new_stampcard = Stampcard.new(stampcards_params.merge(stamp_count: 0))
    #     if new_stampcard.save
    #         render json: new_stampcard, status: 200 and return
    #     else    
    #         render json: {error: 'cant regist stampcard'}, status: 404 and return
    #     end
    # end 

    # def update
    #     exist_stampcard = Stampcard.find_by(user_id: stampcards_params.user_id)
    # end 

    # def stamp

    #     exist_stampcard = Stampcard.find_by(user_id: stampcards_params.user_id)
    #     if exist_stampcard.present?
    #         render json: {error: 'stampcard record was already registored'}, status: 404 and return
    #     end

    #     currente_stampcount = exist_stampcard.stamp_count
    #     currente_stampcount += 1;
    #     exist_stampcard.stamp_count = currente_stampcount;

    #     if exist_stampcard.save
    #         render json: exist_stampcard, status: 200 and return
    #     else
    #         render json: {error: 'cant stamp to stampcard'}, status: 404 and return
    #     end

    # end 

    def create

    end

    def update

    end

    def destroy

    end

    def show

    end

    def index

    end

    private

    def stampcards_params
        params.permit()
    end
end
