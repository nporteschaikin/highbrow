module Foursquare
  module Adapters
    class UserAdapter
      def initialize(node)
        @node = node
      end

      def attributes
        {
          external_id:         node.fetch("id"),
          external_created_at: Time.at(node.fetch("createdAt")),
          first_name:          node.fetch("firstName"),
          last_name:           node.fetch("lastName"),
          city:                node.fetch("homeCity"),
          check_ins_count:     node.fetch("checkins").fetch("count"),
        }
      end

      private

      attr_reader :node
    end
  end
end
