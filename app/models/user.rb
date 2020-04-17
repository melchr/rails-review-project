class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :name, uniqueness: true, length: {in: 3..20}, presence: true
    has_many :reviews
    has_many :albums, through: :reviews
end
