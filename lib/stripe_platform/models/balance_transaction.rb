module StripePlatform
  module Models
    class BalanceTransaction
      # Returns an instance of the balance transaction
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::BalanceTransaction]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the id
      #
      # @return [String]
      def id
        @attributes['id']
      end

      # Returns the source id
      #
      # @note: this will be polymorphic by the type
      #
      # @return [String]
      def source_id
        @attributes['source']
      end

      # Returns the object type
      #
      # @return [String]
      def object
        @attributes['object']
      end

      # Returns the description
      #
      # @return [String]
      def description
        @attributes['description']
      end

      # Returns the exchange rate value
      #
      # @return [Decimal]
      def exchange_rate_value
        @attributes['exchange_rate']
      end

      # Returns the exchange rate
      #
      # @return [BigDecimal,NilClass]
      def exchange_rate
        begin
          BigDecimal(self.exchange_rate_value.to_s)
        rescue
          nil
        end
      end

      # Returns true if there is an exchange rate
      #
      # @return [Boolean]
      def exchange_rate?
        !self.exchange_rate.nil?
      end

      # Returns the fee details attributes
      #
      # @return [Array]
      def fee_details_attributes
        Array(@attributes.fetch('fee_details', []))
      end

      # Returns an instance of the fee details
      #
      # @return [StripePlatform::Models::FeeDetails]
      def fee_details
        StripePlatform::Models::FeeDetails.new(self.fee_details_attributes)
      end

      # Returns true if there are any fee details
      #
      # @return [Boolean]
      def fee_details?
        self.fee_details.any?
      end

      # Returns the amount as an integer
      #
      # @return [Integer]
      def amount_integer
        @attributes['amount'].to_i
      end

      # Returns the amount as a decimal
      #
      # @return [BigDecimal,NilClass]
      def amount_decimal
        begin
          BigDecimal((self.amount_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      # Returns the currency code
      #
      # @return [String]
      def currency_code
        @attributes['currency']
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

      # Returns the fee integer
      #
      # @return [Integer]
      def fee_integer
        @attributes['fee'].to_i
      end

      # Returns the fee decimal
      #
      # @return [BigDecimal,NilClass]
      def fee_decimal
        begin
          BigDecimal((self.fee_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      # Returns the fee unit
      #
      # @return [StripePlatform::Unit]
      def fee_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.fee_decimal, self.currency_code.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      # Returns the net value integer
      #
      # @return [Integer]
      def net_integer
        @attributes['net'].to_i
      end

      # Returns the net decimal value
      #
      # @return [BigDecimal,NilClass]
      def net_decimal
        begin
          BigDecimal((self.net_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      # Returns the net unit
      #
      # @return [StripePlatform::Unit]
      def net_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.net_decimal, self.currency_code.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      # Returns the reporting category
      #
      # @return [String]
      def reporting_category
        @attributes['reporting_category']
      end

      # Returns the status value
      #
      # @return [String]
      def status_value
        @attributes['status']
      end

      # Returns the type value
      #
      # @return [String]
      def type_value
        @attributes['type']
      end

      # Returns the available on unix timestamp
      #
      # @return [Integer]
      def available_on_unix_timestamp
        @attributes['available_on']
      end

      # Returns the available at time
      #
      # @return [Time,NilClass]
      def available_at
        begin
          Time.at(self.available_on_unix_timestamp).utc
        rescue
          nil
        end
      end

      # Returns true if there is an available time
      #
      # @return [Boolean]
      def available_at?
        !self.available_at.nil?
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

      # Returns the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
