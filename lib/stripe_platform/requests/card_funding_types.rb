module StripePlatform
  module Requests
    class CardFundingTypes

      # Returns a list of the card funding types
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/card_funding_types.json').read)
      end
    end
  end
end
