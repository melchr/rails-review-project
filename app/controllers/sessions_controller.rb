class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        if params[:email]
            @user = User.find_by(email: params[:email])
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect_to albums_path
            else
                render '/login'
            end
        end
    end

    def destroy
        session.clear
        redirect_to root_path
    end

end
