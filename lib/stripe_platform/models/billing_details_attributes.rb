module StripePlatform
  module Models
    class BillingDetails

      # Returns an instance of the card
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Card]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end
    end
  end
end
