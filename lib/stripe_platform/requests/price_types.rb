module StripePlatform
  module Requests
    class PriceTypes

      # Returns a list of the price types
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/price_types.json').read)
      end
    end
  end
end
