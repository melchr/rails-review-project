class Album < ApplicationRecord
    #attr_accessible :artist, :title, :avatar, :user_id
    has_many :reviews
    has_many :users, through: :reviews
    has_one_attached :avatar
end
