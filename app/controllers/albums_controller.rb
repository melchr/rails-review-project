class AlbumsController < ApplicationController
    before_action :set_album, only: [:show, :edit, :update, :destroy]

    def index
        @albums = Album.all
    end

    def show
        @review = @album.reviews.build
    end

    def new
        @album = Album.new
    end

    def create
        @user = User.find(params[:user_id])
        @album = current_user.albums.build(album_params)
        @album.user_id = current_user.id
        if @album.save
            redirect_to album_path(@album)
        else
            render :new
        end
    end

    def edit
    end

    def update
        #@album = current_user.albums.build(album_params)
        @album.user_id = current_user.id
        if @album.update(album_params)
            redirect_to album_path(@album), notice: "Your album has been updated."
        else
            render 'edit'
        end
    end

    def destroy
        @album.delete
        redirect_to albums_path
    end

    private

    def set_album
        @album = Album.find(params[:id])
    end

    def album_params
        params.require(:album).permit(:artist, :title, :avatar, :user_id, review_attributes:[:title, :date, :content, :user_id, :album_id])
    end
end
