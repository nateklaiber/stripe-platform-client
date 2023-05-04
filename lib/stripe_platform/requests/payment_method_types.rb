module StripePlatform
  module Requests
    class PaymentMethodTypes

      # Returns a list of the payment method types
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/payment_method_types.json').read)
      end
    end
  end
end
