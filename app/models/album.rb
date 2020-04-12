class Album < ApplicationRecord
    has_many :reviews
    has_many :users, through: :reviews
    has_one_attached :avatar
end
