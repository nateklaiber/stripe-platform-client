module StripePlatform
  module Models
    class CardChecks

      # Returns an instance of the card checks
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::CardChecks]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the address line 1 check
      #
      # @return [String]
      def address_line_1_check
        @attributes['address_line_1_check']
      end

      # Returns the address postal code check
      #
      # @return [String]
      def address_postal_code_check
        @attributes['address_postal_code_check']
      end

      # Returns the cvc check
      #
      # @return [String]
      def cvc_check
        @attributes['cvc_check']
      end

      # Returns original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end

