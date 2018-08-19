module Foursquare
  class Client < Faraday::Connection
    URL = "https://api.foursquare.com/v2/".freeze
    VERSION = 20180820

    def initialize(token = nil)
      super(url: URL, params: { v: VERSION }) do |connection|
        if token.present?
          connection.params.merge!(
            oauth_token: token,
          )
        else
          connection.params.merge!(
            client_id:      ENV.fetch("FOURSQUARE_OAUTH_CLIENT_ID"),
            client_secret:  ENV.fetch("FOURSQUARE_OAUTH_CLIENT_SECRET"),
          )
        end

        connection.request  :json
        connection.response :json
        connection.response :logger, Rails.logger
        connection.use      Faraday::Response::RaiseError
        connection.adapter  Faraday.default_adapter
      end
    end
  end
end
