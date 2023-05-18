module StripePlatform
  module Requests
    class PaymentIntentStatuses

      # Returns a list of the payment intent statuses
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/payment_intent_statuses.json').read)
      end
    end
  end
end
