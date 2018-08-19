module Foursquare
  class OauthClient < OAuth2::Client
    AUTHORIZE_URL = "https://foursquare.com/oauth2/authenticate".freeze
    TOKEN_URL     = "https://foursquare.com/oauth2/access_token".freeze

    def initialize
      super(
        ENV.fetch("FOURSQUARE_OAUTH_CLIENT_ID"),
        ENV.fetch("FOURSQUARE_OAUTH_CLIENT_SECRET"),
        authorize_url:  AUTHORIZE_URL,
        token_url:      TOKEN_URL,
      )
    end
  end
end
