class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
        @user = current_user
        @reviews = @user.reviews
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

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password_digest)
    end
end
