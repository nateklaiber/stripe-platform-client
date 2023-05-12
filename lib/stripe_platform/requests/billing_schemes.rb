module StripePlatform
  module Requests
    class BillingSchemes

      # Returns a list of the billing schemes
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/billing_schemes.json').read)
      end
    end
  end
end
