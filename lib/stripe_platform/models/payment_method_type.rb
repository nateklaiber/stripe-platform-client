module StripePlatform
  module Models
    class PaymentMethodType

      # Returns an instance of the payment method type
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::PaymentMethodType]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the id
      #
      # @return [String]
      def id
        @attributes['id']
      end

      # Returns the description
      #
      # @return [String]
      def description
        @attributes['description']
      end

      def object_for(record_attributes)
        case(self.id)
        when('card')
          StripePlatform::Models::Card.new(record_attributes)
        when('us_bank_account')
          StripePlatform::Models::UsBankAccount.new(record_attributes)
        end
      end

      # Returns true if this is a card
      #
      # @return [Boolean]
      def card?
        'card' == self.id
      end

      # Returns the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
