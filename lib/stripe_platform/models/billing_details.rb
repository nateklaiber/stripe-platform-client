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

      def address_attributes
        Hash(@attributes.fetch('address', {}))
      end

      def address
        StripePlatform::Models::Address.new(self.address_attributes)
      end

      def email
        @attributes['email']
      end

      def name
        @attributes['name']
      end

      def phone
        @attributes['phone']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
