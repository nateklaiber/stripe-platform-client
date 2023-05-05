module StripePlatform
  module Models
    class PaymentMethod
      include Comparable

      # Returns an instance of the payment method
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::PaymentMethod]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the id
      #
      # @return [String]
      def id
        @attributes['id']
      end

      def customer_id
        @attributes['customer']
      end

      def customer
        StripePlatform::Models::Customers.retrieve(self.customer_id)
      end

      def customer?
        !self.customer.nil?
      end

      def object
        @attributes['object']
      end

      def billing_details_attributes
        Hash(@attributes.fetch('billing_details', {}))
      end

      def billing_details
        @billing_details ||= StripePlatform::Models::BillingDetails.new(self.billing_details_attributes)
      end

      def type_id
        @attributes['type']
      end

      def type
        StripePlatform::Models::PaymentMethodTypes.retrieve(self.type_id)
      end

      def card_attributes
        Hash(@attributes.fetch('card', {}))
      end

      def source
        self.type.object_for(self.card_attributes)
      end

      def card
        @card ||= StripePlatform::Models::Card.new(self.card_attributes)
      end

      def card?
        !self.card.nil?
      end

      # Returns the created unix timestamp
      #
      # @return [Integer]
      def created_unix_timestamp
        @attributes['created']
      end

      # Returns the created at time
      #
      # @return [Time,NilClass]
      def created_at
        begin
          Time.at(self.created_unix_timestamp).utc
        rescue
          nil
        end
      end

      # Returns true if there is a created at
      #
      # @return [Boolean]
      def created_at?
        !self.created_at.nil?
      end

      def to_attributes
        @attributes
      end
    end
  end
end
