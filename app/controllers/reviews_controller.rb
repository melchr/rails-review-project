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
        @album = Album.find(params[:album_id])
        @review.album = @album
        if @review.save
            redirect_to album_path(@album)
        else
            render :new
        end
    end

    def update
        if @album.review.update(review_params)
            redirect_to album_path(@album), notice: "Your review has been updated."
        else
            render 'edit'
        end
    end

    private

    def review_params
        params.require(:review).permit(:title, :date, :content, :user_id, :album_id, album_attributes:[:artist, :title, :user_id])
    end

end
