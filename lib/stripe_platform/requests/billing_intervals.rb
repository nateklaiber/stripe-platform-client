module StripePlatform
  module Requests
    class BillingIntervals

      # Returns a list of the billing intervals
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/billing_intervals.json').read)
      end
    end
  end
end
