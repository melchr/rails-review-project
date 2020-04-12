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
        @review = current_user.reviews.build(review_params)
        if @review.save
            redirect_to reviews_path
        else
            render :new
        end
    end

    def update

    end

    private

    def review_params
        params.require(:review).permit(:title, :date, :content, :user_id, :album_id, album_attributes:[:artist, :title])
    end

end
