class ReviewsController < ApplicationController
    before_action :set_review, only: [:show, :edit, :update, :destroy]

    def index
        @user = current_user
        @albums = Album.with_recent_reviews
    end

    def show
        #@reviews = Review.where("album_id = ?", params[:album_id])
    end

    def new
        @review = Review.new
        @user = current_user
        @album = Album.find(params[:album_id])
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
    
    def edit
    end

    def update
        if @album.review.update(review_params)
            redirect_to album_path(@album), notice: "Your review has been updated."
        else
            render 'edit'
        end
    end

    def destroy
    end

    private

    def set_review
        @review = Review.find(params[:id])
    end

    def review_params
        params.require(:review).permit(:title, :date, :content, :user_id, :album_id, album_attributes:[:artist, :title, :user_id])
    end

end
