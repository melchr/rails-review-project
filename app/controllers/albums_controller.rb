class AlbumsController < ApplicationController

    def index
        @albums = Album.all
        @current_user
    end

    def show
        @album = Album.find(params[:id])
    end

    def new
        @album = Album.new
    end

    def create
        @album = Album.new(album_params)
        if @album.save
            redirect_to album_path(@album)
        else
            render :new
        end
    end

    private

    def album_params
        params.require(:album).permit(:artist, :title, :avatar)
    end
end
