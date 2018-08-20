module Foursquare
  module Adapters
    class CheckInUserAdapter
      def initialize(node)
        @node = node
      end

      def attributes
        {
          relationship: node["relationship"],
        }
      end

      private

      attr_reader :node
    end
  end
end
