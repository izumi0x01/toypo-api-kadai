class Api::V1::StampcardsController < ApplicationController

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

    def stampcard_contents_params
        params.permit(:user_id, :stampcard_content_id, :pushed_stamp_count)
    end
end
