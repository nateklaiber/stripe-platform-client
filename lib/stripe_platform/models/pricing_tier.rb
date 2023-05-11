module StripePlatform
  module Models
    class PricingTier

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def tiers_mode_value
        @attributes['tiers_mode']
      end
      alias tiers_mode_id tiers_mode_value

      def tiers_mode
        @tiers_mode ||= StripePlatform::Models::PricingTiersModes.retrieve(self.tiers_mode_value)
      end
      alias pricing_tiers_mode tiers_mode

      def tiers_mode?
        !self.tiers_mode.nil?
      end
      alias pricing_tiers_mode? tiers_mode?


      def currency_code
        @attributes['currency']
      end

      def flat_amount
        @attributes['flat_amount']
      end

      def flat_amount_decimal
        @attributes['flat_amount_decimal']
      end

      def unit_amount
        @attributes['unit_amount']
      end

      def unit_amount_decimal
        @attributes['unit_amount_decimal']
      end

      def up_to_count
        @attributes['up_to']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
