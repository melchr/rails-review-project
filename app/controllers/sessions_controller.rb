class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @message = params[:password].empty? || params[:email].empty? ? "Please include your Email & Password" : nil
        if params[:email]
            @user = User.find_by(email: params[:email])
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect_to albums_path
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
