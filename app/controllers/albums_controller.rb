class AlbumsController < ApplicationController
    before_action :set_current_user, only: [:index, :new, :edit]
    before_action :set_album, only: [:show, :edit, :update, :destroy]
    before_action :must_login, only: [:new, :show, :create, :edit, :update, :destroy]

    def index
        @albums = Album.all.order("artist ASC")

    end

    def show
        @review = @album.reviews.build
        @review.user = current_user
        @reviews = Review.recent #scope
    end

    def new
        @album = Album.new
        @review = @album.reviews.build
        @user = current_user
    end

    def create
        @album = current_user.albums.build(album_params)
        @album.reviews.each { |r| r.user ||= current_user } # I'm using ||= so i can use the same code on update without changing reviews that already have a user
        if @album.save
            redirect_to album_path(@album)
        else
            render :new
        end
    end

    def edit

    end

    def update
        @album.user_id = current_user.id
        if @album.update(album_params)
            redirect_to album_path(@album), notice: "Your album has been updated."
        else
            render 'edit'
        end
    end

    def destroy
        @album.destroy #destroy is for associated objects
        @album.avatar.purge
        redirect_to albums_path
    end

    private

    def set_current_user
        @user = current_user
    end

    def set_album
        @album = Album.exists?(params[:id]) ? Album.find(params[:id]) : nil
        redirect_to not_found_path if @album.nil? 
        #render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found if @album.nil? #conditional still works at end 
    end

    def album_params
        params.require(:album).permit(:artist, :title, :avatar, :user_id, reviews_attributes:[:title, :date, :content]) #removed the :user_id and :album_id from the permitted parameters for reviews_attributes, don't want users to exploit that assignation adding those parameters that I'm actually not using
    end
end
