module StripePlatform
  module Models
    class Charge
      # Returns an instance of the charge
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::BalanceTransaction]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def balance_transaction_id
        @attributes['balance_transaction']
      end

      def balance_transaction
        @balance_transaction ||= StripePlatform::Models::BalanceTransactions.retrieve(self.balance_transaction_id)
      end

      def balance_transaction?
        !self.balance_transaction.nil?
      end

      def billing_details_attributes
        Hash(@attributes.fetch('billing_details', {}))
      end

      def billing_details
        @billing_details ||= StripePlatform::Models::BillingDetails.new(self.billing_details_attributes)
      end

      def calculated_statement_descriptor
        @attributes['calculated_statement_descriptor']
      end

      def is_captured
        @attributes['captured']
      end
      alias is_captured? is_captured
      alias captured? is_captured

      def is_paid
        @attributes['paid']
      end
      alias is_paid? is_paid
      alias paid? is_paid

      def is_refunded
        @attributes['refunded']
      end
      alias is_refunded? is_refunded
      alias refunded? is_refunded

      def is_disputed
        @attributes['disputed']
      end
      alias is_disputed? is_disputed
      alias disputed? is_disputed

      def statement_descriptor
        @attributes['statement_descriptor']
      end

      def statement_descriptor_suffix
        @attributes['statement_descriptor_suffix']
      end

      def status_value
        @attributes['status']
      end

      def customer_id
        @attributes['customer']
      end

      def customer
        @customer ||= StripePlatform::Models::Customers.retrieve(self.customer_id)
      end

      def customer?
        !self.customer.nil?
      end

      def payment_intent_id
        @attributes['payment_intent']
      end

      def payment_intent
        @payment_intent ||= StripePlatform::Models::PaymentIntents.retrieve(self.payment_intent_id)
      end

      def payment_intent?
        !self.payment_intent.nil?
      end

      def payment_method_id
        @attributes['payment_method']
      end

      def payment_method
        @payment_method ||= StripePlatform::Models::PaymentMethods.retrieve(self.payment_method_id)
      end

      def payment_method?
        !self.payment_method.nil?
      end

      def description
        @attributes['description']
      end

      def metadata_attributes
        Hash(@attributes.fetch('metadata', {}))
      end

      def metadata
        @metadata ||= StripePlatform::Models::Metadata.new(self.metadata_attributes)
      end

      # Returns the currency code
      #
      # @return [String]
      def currency_code
        @attributes['currency']
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

      # Returns the amount refunded as an integer
      #
      # @return [Integer]
      def amount_refunded_integer
        @attributes['amount_refunded'].to_i
      end

      # Returns the amount refunded as a decimal
      #
      # @return [BigDecimal,NilClass]
      def amount_refunded_decimal
        begin
          BigDecimal((self.amount_refunded_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      # Returns the amount refunded unit
      #
      # @return [StripePlatform::Unit]
      def amount_refunded_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.amount_refunded_decimal, self.currency_code.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
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
