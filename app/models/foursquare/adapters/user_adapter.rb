module Foursquare
  module Adapters
    class UserAdapter
      SIZE = "300x500".freeze

      def initialize(node)
        @node = node
      end

      def attributes
        {
          external_id:         node.fetch("id"),
          first_name:          node["firstName"],
          last_name:           node["lastName"],

          city:                node["homeCity"],
          external_created_at: (epoch = node["createdAt"]).present? ? Time.at(epoch) : nil,
          check_ins_count:     node.fetch("checkins", {})["count"],
          photo_prefix:        node.fetch("photo", {})["prefix"],
          photo_suffix:        node.fetch("photo", {})["suffix"],
        }.compact
      end

      private

      attr_reader :node
    end
  end
end
