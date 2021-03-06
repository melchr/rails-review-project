require 'securerandom'
class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :name, uniqueness: true, length: {in: 3..20}, presence: true
    
    has_many :reviews
    has_many :reviewed_albums, through: :reviews, source: :album
    has_many :albums

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.name = auth.info.name
          user.email = auth.info.email
          user.password = SecureRandom.urlsafe_base64
          user.oauth_token = auth.credentials.token
          user.oauth_expires_at = Time.at(auth.credentials.expires_at)
          user.save!
        end
      end

end
