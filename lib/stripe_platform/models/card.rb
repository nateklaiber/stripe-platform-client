module StripePlatform
  module Models
    class Card

      # Returns an instance of the card
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Card]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the id
      #
      # @return [String]
      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def brand_id
        @attributes['brand']
      end
      alias card_brand_id brand_id

      def brand
        @brand ||= StripePlatform::Models::CardBrands.retrieve(self.brand_id)
      end
      alias card_brand brand

      def brand?
        !self.brand.nil?
      end
      alias card_brand? brand?

      def country_code
        @attributes['country']
      end

      def exp_month
        @attributes['exp_month']
      end
      alias expiration_month exp_month

      def exp_year
        @attributes['exp_year']
      end
      alias expiration_year exp_year

      def last_4
        @attributes['last4']
      end
      alias last4 last_4

      def fingerprint
        @attributes['fingerprint']
      end

      def funding_type_id
        @attributes['funding']
      end
      alias card_funding_type_id funding_type_id

      def funding_type
        @funding_type ||= StripePlatform::Models::CardFundingTypes.retrieve(self.funding_type_id)
      end
      alias card_funding_type funding_type

      def funding_type?
        !self.funding_type.nil?
      end
      alias card_funding_type? funding_type?

      def checks_attributes
        Hash(@attributes.fetch('checks', {}))
      end

      def checks
        @checks ||= StripePlatform::Models::CardChecks.new(self.checks_attributes)
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
