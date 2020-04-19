require 'omniauth-google-oauth2'
require 'dotenv'

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret

    Dotenv.load
  end