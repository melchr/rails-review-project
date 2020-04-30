class ReviewsController < ApplicationController
    before_action :set_review, only: [:show, :edit, :update, :destroy]
    before_action :set_current_user, only: [:index, :show, :new, :edit, :destroy]
    before_action :find_album, only: [:show, :create, :edit, :update, :destroy]
    before_action :must_login, only: [:index, :show, :new, :create, :edit, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        @albums = Album.with_recent_reviews #scope
    end

    def show

        #@reviews = Review.where("album_id = ?", params[:album_id])
    end

    def new
        if params[:album_id] && @album = Album.find_by(id: params[:user_id])
            @review = @album.reviews.build
        else
            redirect_to albums_path
        end
    end

    def create
        @review = current_user.reviews.build(review_params)
        #@review.album = @album
        if @review.save
            redirect_to album_path(@album)
        else
            #@review.album
            render :new
        end
    end
    
    def edit
        if current_user.id == @review.user_id
            @album.reviews.find(params[:id])
            redirect_to album_path(params[:album_id])
          else
             redirect_to album_path(@album)
        end
    end

    def update
        if @review.update(review_params)
            redirect_to album_path(params[:album_id])
        else
            render 'edit'
        end
    end

    def destroy
        if current_user.id == @review.user_id
          @album.reviews.find(params[:id]).destroy
          redirect_to album_path(params[:album_id])
        else
           flash[:error] = "Unable to delete your review. Please try again."
           redirect_to album_reviews_path(@review)
        end
      end

    private

    def record_not_found
        redirect_to not_found_path
    end

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
        params.require(:review).permit(:title, :date, :content, :album_id, album_attributes:[:artist, :title, :user_id])
    end

end
