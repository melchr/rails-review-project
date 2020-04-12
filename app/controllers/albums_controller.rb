class AlbumsController < ApplicationController
    before_action :set_album, only: [:show, :edit, :update]

    def index
        @albums = Album.all
        @current_user
    end

    def show
        @review = @album.reviews.build
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

    def edit
    end

    def update
        if @album.update(album_params)
            redirect_to album_path(@album), notice: "Your album has been updated."
        else
            render 'edit'
        end
    end

    private

    def set_album
        @album = Album.find(params[:id])
    end

    def album_params
        params.require(:album).permit(:artist, :title, :avatar)
    end
end
