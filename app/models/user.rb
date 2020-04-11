class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :albums, through: :reviews  #<<< understand this
    accepts_nested_attributes_for :reviews
end
