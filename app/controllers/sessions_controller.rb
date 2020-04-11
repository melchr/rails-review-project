class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
         session[:user_id] = user.id
         #flash[:success] = Successfully Logged In!
         redirect_to user_path
        else
         #flash[:warning] = “Invalid Username or Password”
         redirect_to signin_path
        end
       end

    def destroy
        session.clear
        redirect_to root_path
    end

end
