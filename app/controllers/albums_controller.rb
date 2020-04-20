class AlbumsController < ApplicationController
    #before_action :set_current_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
    helper_method :current_user
    before_action :set_album, only: [:show, :edit, :update, :destroy]
    before_action :must_login, only: [:new, :show, :create, :edit, :update, :destroy]

    def index
        @albums = Album.all
        @user = current_user
    end

    def show
        @review = @album.reviews.build
        @review.user = current_user

        @review.save
        @reviews = Review.recent #scope
    end

    def new
        @album = Album.new
        @review = @album.reviews.build
        @user = current_user
    end

    def create
        #@user = User.find(current_user.id)
        @album = current_user.albums.build(album_params)
        #@album.user_id = current_user.id
        @album.reviews.each { |r| r.user ||= current_user } # I'm using ||= so i can use the same code on update without changing reviews that already have a user
        if @album.save
            redirect_to album_path(@album)
        else
            render :new
        end
    end

    def edit
        @user = current_user
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
        @album.avatar.purge
        redirect_to albums_path
    end

    private

    def set_album
        @album = Album.find(params[:id])
    end

    def album_params
        params.require(:album).permit(:artist, :title, :avatar, :user_id, reviews_attributes:[:title, :date, :content]) #removed the :user_id and :album_id from the permitted parameters for reviews_attributes, don't want users to exploit that assignation adding those parameters that I'm actually not using
    end
end
