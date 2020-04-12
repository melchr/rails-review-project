class ReviewsController < ApplicationController

    def index
        @reviews = Review.all
    end

    def show
        @review = Review.find(params[:id])
        #@reviews = Review.where("album_id = ?", params[:album_id])
    end

    def new
        @review = Review.new
    end

    def create
        @album = Album.find(params[:album_id])
        current_user.reviews.create(review_params)
        redirect_to @album
    end

    def update

    end

    private

    def review_params
        params.require(:review).permit(:title, :date, :content)
    end

end
