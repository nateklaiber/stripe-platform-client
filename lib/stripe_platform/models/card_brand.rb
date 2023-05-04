module StripePlatform
  module Models
    class CardBrand

      # Returns an instance of the card brand type
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::CardBrand]
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

      # Returns true if this is a visa
      #
      # @return [Boolean]
      def visa?
        'visa' == self.id
      end

      # Returns true if this is a mastercard
      #
      # @return [Boolean]
      def mastercard?
        'mastercard' == self.id
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
