module StripePlatform
  module Requests
    class PricingTiersModes

      # Returns a list of the pricing tiers modes
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/pricing_tiers_modes.json').read)
      end
    end
  end
end
