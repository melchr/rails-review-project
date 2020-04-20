class UsersController < ApplicationController
    before_action :set_current_user, only: [:index, :show, :new, :edit, :destroy]
    #before_action :set_review, only: [:show, :edit, :update, :destroy]
    before_action :set_user, only: [:edit, :update, :destroy]
    #before_action :find_album, only: [:show, :create, :edit, :update, :destroy]
    before_action :must_login, only: [:index, :show, :edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
        @reviews = current_user.reviews
        @album = @user.albums
        #@album = @user.albums
        #@reviews = Review.all
       # @review = @album.reviews.build
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to albums_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        @user.update(user_params(:name, :email, :password_digest))
        redirect_to user_path(@user)
    end

    def destroy
        @user = User.destroy
    end

    private

   # def set_review
   #     @review = Review.find(params[:id])
   # end

    def set_user
        @user = User.find(params[:id])
    end

    def set_current_user
        @user = current_user
    end

    #def find_album
    #    @album = Album.find(params[:album_id])
    #end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
