module Foursquare
  module Adapters
    class CheckInAdapter
      def initialize(node)
        @node = node
      end

      def attributes
        {
          external_id:         node.fetch("id"),
          external_created_at: Time.at(node.fetch("createdAt")),
          likes_count:         node.fetch("likes").fetch("count"),
          comments_count:      node.fetch("comments").fetch("count"),
          mayor:               node.fetch("isMayor"),
          shout:               node["shout"],
        }
      end

      private

      attr_reader :node
    end
  end
end
