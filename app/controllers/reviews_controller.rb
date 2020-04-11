class ReviewsController < ApplicationController

    def show
        @reviews = Review.where("album_id = ?", params[:album_id])
    end

end
