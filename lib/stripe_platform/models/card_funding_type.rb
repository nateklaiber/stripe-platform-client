module StripePlatform
  module Models
    class CardFundingType

      # Returns an instance of the card funding type
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::CardFundingType]
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

      # Returns true if this is a credit
      #
      # @return [Boolean]
      def credit?
        'credit' == self.id
      end

      # Returns true if this is a debit
      #
      # @return [Boolean]
      def debit?
        'debit' == self.id
      end

      # Returns true if this is a prepaid
      #
      # @return [Boolean]
      def prepaid?
        'prepaid' == self.id
      end

      # Returns true if this is uknown
      #
      # @return [Boolean]
      def uknown?
        'unknown' == self.id
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
