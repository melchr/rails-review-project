class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :logged_in?

    private

    

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!session[:user_id]
    end

    def must_login
        if !logged_in?
            redirect_to signin_path
        end
    end

end
