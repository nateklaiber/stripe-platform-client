module StripePlatform
  module Requests
    class RefundStatuses

      # Returns a list of the refund statuses
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/refund_statuses.json').read)
      end
    end
  end
end
