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
          first_name:          node.fetch("firstName"),
          last_name:           node.fetch("lastName"),

          city:                node["homeCity"],
          external_created_at: (epoch = node["createdAt"]).present? ? Time.at(epoch) : nil,
          check_ins_count:     node.fetch("checkins", {})["count"],
          avatar_url:          avatar_url,
        }
      end

      private

      attr_reader :node

      def avatar_url
        if (photo = node["photo"]).present?
          "%s%s%s" % [photo.fetch("prefix"), SIZE, photo.fetch("suffix")]
        end
      end
    end
  end
end
