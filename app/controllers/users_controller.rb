class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
        
    end

    def new
        @user = User.new
    end

    def create
        @user = User.create
        redirect_to user_path(@user)
    end

    def edit
    end

    def update
        @user.update(user_params(:name, :email, :password_digest))
        redirect_to user_path(@user)
    end

    private

    def set_user
        User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password_digest)
    end
end
