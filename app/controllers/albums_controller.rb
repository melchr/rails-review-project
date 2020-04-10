class AlbumsController < ApplicationController

    def index
        @albums = Album.all
    end

    def show

    end

    def new
        @album = Album.new
    end
end
