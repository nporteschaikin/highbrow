module Foursquare
  module Adapters
    class VenueAdapter
      def initialize(node)
        @node = node
      end

      def attributes
        {
          external_id:                  node.fetch("id"),
          name:                         node.fetch("name"),
          categories:                   node.fetch("categories").map { |category| category.fetch("name") },

          location_lat:                 node.fetch("location").fetch("lat"),
          location_lng:                 node.fetch("location").fetch("lng"),
          location_country_code:        node.fetch("location").fetch("cc"),
          location_country:             node.fetch("location").fetch("country"),
          location_formatted_address:   node.fetch("location").fetch("formattedAddress"),
          location_address:             node.fetch("location")["address"],
          location_city:                node.fetch("location")["city"],
          location_state:               node.fetch("location")["state"],
          location_postal_code:         node.fetch("location")["postalCode"],

          #contact_phone:                node.fetch("contact", {})["phone"],
          #contact_facebook_id:          node.fetch("contact", {})["facebook"],
          #contact_facebook_name:        node.fetch("contact", {})["facebookName"],
          #contact_facebook_username:    node.fetch("contact", {})["facebookUsername"],

          #verified:                     node["verified"],

          #external_tips_count:          node.fetch("stats").fetch("tipCount"),
          #external_users_count:         node.fetch("stats").fetch("usersCount"),
          #external_check_ins_count:     node.fetch("stats").fetch("checkinsCount"),

          rating:                       node["rating"],
          #rating_color:                 node["ratingColor"],
          #rating_signals:               node["ratingSignals"],
        }
      end

      private

      attr_reader :node
    end
  end
end
