class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        if params[:user]
            @user = User.find_by(email: params[:user][:email])
            if @user && @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                redirect_to signin_path
            end
        end
    end

    def destroy
        session.clear
        redirect_to root_path
    end

end
