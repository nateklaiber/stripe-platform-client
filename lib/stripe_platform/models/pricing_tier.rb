module StripePlatform
  module Models
    class PricingTier
      include Comparable

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def <=>(other)
        self.index <=> other.index
      end

      def index
        @attributes['index']
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

      def flat_amount_decimal
        @attributes['flat_amount_decimal']
      end

      # Returns the flat amount as an integer
      #
      # @return [Integer]
      def flat_amount_integer
        @attributes['flat_amount'].to_i
      end

      # Returns the flat amount as a decimal
      #
      # @return [BigDecimal,NilClass]
      def flat_amount_decimal
        begin
          BigDecimal((self.flat_amount_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      # Returns the flat amount unit
      #
      # @return [StripePlatform::Unit]
      def flat_amount_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.flat_amount_decimal, self.currency_code.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      def unit_amount_decimal
        @attributes['unit_amount_decimal']
      end

      # Returns the unit amount as an integer
      #
      # @return [Integer]
      def unit_amount_integer
        @attributes['unit_amount'].to_i
      end

      # Returns the unit amount as a decimal
      #
      # @return [BigDecimal,NilClass]
      def unit_amount_decimal
        begin
          BigDecimal((self.unit_amount_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      # Returns the unit amount unit
      #
      # @return [StripePlatform::Unit]
      def unit_amount_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.unit_amount_decimal, self.currency_code.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      def up_to_count
        @attributes['up_to']
      end

      def start_at_count
        @attributes['start_at']
      end
      alias start_count start_at_count

      def end_at_count
        @attributes['end_at']
      end
      alias end_count end_at_count

      def range
        if self.end_count
          Range.new(self.start_count, self.end_count)
        else
          Range.new(self.start_count, Float::INFINITY)
        end
      end

      def matches_for_quantity?(quantity)
        quantity_value = Integer(quantity.to_s)

        self.range.include?(quantity_value)
      end

      def to_attributes
        @attributes
      end
    end
  end
end
