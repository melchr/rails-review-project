class User < ApplicationRecord
    has_secure_password
    validates_presence_of :password, :on => :create
    validates_format_of :name, :with => /[A-Za-z]+/, :on => :create
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
    validates_length_of :password, :minimum => 5, :on => :create
    has_many :reviews
    has_many :albums, through: :reviews  #<<< understand this
    accepts_nested_attributes_for :reviews
end
