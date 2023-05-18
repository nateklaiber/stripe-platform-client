module StripePlatform
  module Requests
    class SubscriptionStatuses

      # Returns a list of the subscription statuses
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/subscription_statuses.json').read)
      end
    end
  end
end
