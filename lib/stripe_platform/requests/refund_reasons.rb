module StripePlatform
  module Requests
    class RefundReasons

      # Returns a list of the refund reasons
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/refund_reasons.json').read)
      end
    end
  end
end
