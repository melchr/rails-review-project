class PagesController < ApplicationController
    before_action :current_user

    def not_found

    end

    private

    def current_user
        super() #looks for same method on what i'm inheriting from (applicationcontroller)
    end

end