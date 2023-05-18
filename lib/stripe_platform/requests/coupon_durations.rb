module StripePlatform
  module Requests
    class CouponDurations

      # Returns a list of the coupon durations
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/coupon_durations.json').read)
      end
    end
  end
end
