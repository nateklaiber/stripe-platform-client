module StripePlatform
  module Requests
    class TaxBehaviors

      # Returns a list of the tax behaviors
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/tax_behaviors.json').read)
      end
    end
  end
end
