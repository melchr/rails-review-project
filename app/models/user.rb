class User < ApplicationRecord
    has_many :reviews
    has_many :comments, through: :reviews
end
