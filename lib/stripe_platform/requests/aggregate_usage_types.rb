module StripePlatform
  module Requests
    class AggregateUsageTypes

      # Returns a list of the aggregate usage types
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/aggregate_usage_types.json').read)
      end
    end
  end
end
