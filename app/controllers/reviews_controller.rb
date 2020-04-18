class ReviewsController < ApplicationController
    before_action :set_review, only: [:show, :edit, :update, :destroy]
    before_action :set_current_user, only: [:index, :new, :edit]
    before_action :find_album, only: [:create, :edit]
    before_action :must_login, only: [:index, :new, :create, :edit, :update, :destroy]

    def index
        @albums = Album.with_recent_reviews
    end

    def show
        #@reviews = Review.where("album_id = ?", params[:album_id])
    end

    def new
        if params[:album_id] && @album = Album.find_by(id: params[:client_id])
            @review = @album.reviews.build
        else
            redirect_to albums_path
        end
    end

    def create
        @review = current_user.reviews.build(review_params)
        @review.album = @album
        if @review.save
            redirect_to album_path(@album)
        else
            @album = @review.album
            render :new
        end
    end
    
    def edit
    end

    def update
        if @review.update(review_params)
            redirect_to album_path(params[:album_id])
        else
            render 'edit'
        end
    end

    def destroy
        @review.destroy
        redirect_to albums_path
    end

    private

    def set_review
        @review = Review.find(params[:id])
    end

    def set_current_user
        @user = current_user
    end

    def find_album
        @album = Album.find(params[:album_id])
    end

    def review_params
        params.require(:review).permit(:title, :date, :content, :user_id, :album_id, album_attributes:[:artist, :title, :user_id])
    end

end
