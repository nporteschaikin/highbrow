module Foursquare
  module Adapters
    class CategoryAdapter
      def initialize(node)
        @node = node
      end

      def attributes
        {
          external_id:         node.fetch("id"),
          name:                node.fetch("name"),
          icon_prefix:         node.fetch("icon", {})["prefix"],
          icon_suffix:         node.fetch("icon", {})["suffix"],
        }
      end

      private

      attr_reader :node
    end
  end
end
