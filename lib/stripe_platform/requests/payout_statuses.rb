module StripePlatform
  module Requests
    class PayoutStatuses

      # Returns a list of the payout statuses
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/payout_statuses.json').read)
      end
    end
  end
end
