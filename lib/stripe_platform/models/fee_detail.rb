module StripePlatform
  module Models
    class FeeDetail
      # Returns an instance of the fee details
      #
      # @param attributes [Hash]
      #
      # @Return [StripePlatform::Models::FeeDetail]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the application
      #
      # @return [String]
      def application
        @attributes['application']
      end

      # Returns the fee description
      #
      # @return [String]
      def description
        @attributes['description']
      end

      # Returns the type value
      #
      # @return [String]
      def type_value
        @attributes['type']
      end

      # Returns the currency code
      #
      # @return [String]
      def currency_code
        @attributes['currency']
      end

      # Returns the amount integer
      #
      # @return [Integer]
      def amount_integer
        @attributes['amount'].to_i
      end

      def amount_decimal
        begin
          BigDecimal((self.amount_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      # Returns the amount unit
      #
      # @return [StripePlatform::Unit]
      def amount_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.amount_decimal, self.currency_code.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
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
