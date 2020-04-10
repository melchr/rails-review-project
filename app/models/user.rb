class User < ApplicationRecord
    has_many :reviews
    has_many :albums, through: :reviews  #<<< understand this
end
