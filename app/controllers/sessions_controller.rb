class SessionsController < ApplicationController
    def new
        @user = User.new
    end
    def create
        unless params[:email].empty?
            @user = User.find_by_email(params[:email])
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect_to albums_path
            else
                flash[:alert] = "Email or Password Incorrect.  Please try again."
                redirect_to signin_path
            end
        else
            flash[:alert] = "Please include your Email & Password."
            redirect_to signin_path
        end
    end
    def destroy
        session.clear
        redirect_to root_path
    end
end