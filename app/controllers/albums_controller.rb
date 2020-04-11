class AlbumsController < ApplicationController

    def index
        @albums = Album.all
        @current_user
    end

    def show

    end

    def new
        @album = Album.new
    end
end
