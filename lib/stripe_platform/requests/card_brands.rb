module StripePlatform
  module Requests
    class CardBrands

      # Returns a list of the card brand types
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/card_brands.json').read)
      end
    end
  end
end
