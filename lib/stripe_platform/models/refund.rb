module StripePlatform
  module Models
    class Refund
      extend Forwardable

      def_delegator :status, :succeeded?, :status_succeeded?
      def_delegator :status, :pending?, :status_pending?
      def_delegator :status, :failed?, :status_failed?
      def_delegator :status, :canceled?, :status_canceled?
      def_delegator :status, :requies_action?, :status_requires_action?

      # Returns an instance of the charge
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Refund]
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

      def status_value
        @attributes['status']
      end

      def status
        @status ||= StripePlatform::Models::RefundStatuses.retrieve(self.status_value)
      end

      def reason_value
        @attributes['reason']
      end

      def reason
        @reason ||= StripePlatform::Models::RefundReasons.retrieve(self.reason_value)
      end

      def charge_id
        @attributes['charge']
      end

      def charge
        @charge ||= StripePlatform::Models::Charges.retrieve(self.charge_id)
      end

      def charge?
        !self.charge.nil?
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
