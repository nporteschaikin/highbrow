require "net/http"

module Foursquare
  class RatingFinder
    URL       = "https://foursquare.com".freeze
    PATH      = "/v/%s".freeze
    SELECTOR  = ".venueRateBlock .venueScore".freeze

    def initialize(venue)
      @venue = venue
    end

    def find
      unless element.nil?
        element.text.split("/").first.to_f
      end
    end

    private

    attr_reader :venue

    def element
      @element ||= tree.css(SELECTOR)[0]
    end

    def tree
      @tree ||= Nokogiri::HTML(response.body)
    end

    def response
      client.get(PATH % venue.external_id)
    end

    def client
      Faraday.new(url: URL) do |connection|
        connection.response :follow_redirects
        connection.use      Faraday::Response::RaiseError
        connection.adapter  Faraday.default_adapter
      end
    end
  end
end
