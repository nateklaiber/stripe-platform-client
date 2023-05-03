module StripePlatform
  module Models
    class Payout
      include Comparable
      extend Forwardable

      def_delegator :status, :paid?, :status_paid?
      def_delegator :status, :pending?, :status_pending?
      def_delegator :status, :in_transit?, :status_in_transit?
      def_delegator :status, :canceled?, :status_canceled?
      def_delegator :status, :failed?, :status_failed?

      # Returns an instance of the payout
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Payout]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the id
      #
      # @return [String]
      def id
        @attributes['id']
      end

      # Returns the value of the balance transaction
      #
      # Unfortunately this gets overloaded to mean two different
      # things depending on expansion. We want to keep the concerns
      # separate between `balance_transaction_id` and `balance_transaction_attributes`
      #
      # @return [String,Hash]
      def balance_transaction_value
        @attributes['balance_transaction']
      end

      # Returns the associated balance transaction id if the
      # type is a string
      #
      # @return [String,NilClass]
      def balance_transaction_id
        if self.balance_transaction_value.kind_of?(String)
          self.balance_transaction_value
        else
          nil
        end
      end

      # Returns true if there is a balance transaction id
      #
      # @return [Boolean]
      def balance_transaction_id?
        !self.balance_transaction_id.nil?
      end

      # Returns the balance transaction attributes
      # if the type is a Hash
      #
      # @return [Hash]
      def balance_transaction_attributes
        if self.balance_transaction_value.kind_of?(Hash)
          Hash(self.balance_transaction_value)
        else
          {}
        end
      end

      # Returns true if there are any balance transaction attributes. This
      # would signal that it was expanded
      #
      # @return [Boolean]
      def balance_transaction_attributes?
        !self.balance_transaction_attributes.empty?
      end

      # This returns the associated balance transaction
      #
      # @return [StripePlatform::Models::BalanceTransaction]
      def balance_transaction
        if self.balance_transaction_id?
          StripePlatform::Models::BalanceTransactions.retrieve(self.balance_transaction_id)
        elsif self.balance_transaction_attributes?
          StripePlatform::Models::BalanceTransaction.new(self.balance_transaction_attributes)
        else
          nil
        end
      end

      # Returns true if there is no balance transaction
      #
      # @return [Boolean]
      def balance_transaction?
        !self.balance_transaction.nil?
      end

      # Returns the associated destination id
      #
      # @return [String]
      def destination_id
        @attributes['destination']
      end

      # Returns true if the payout was created by an automated payout schedule, and false
      # if it was requested manually
      #
      # @return [Boolean]
      def is_automatic
        @attributes['automatic']
      end
      alias is_automatic? is_automatic
      alias automatic? is_automatic

      # Returns the object type
      #
      # @return [String]
      def object
        @attributes['object']
      end

      # Returns the method
      #
      # @return [String]
      def method
        @attributes['method']
      end

      # Returns the description
      #
      # @return [String]
      def description
        @attributes['description']
      end

      # Returns the statement descriptor
      #
      # @return [String]
      def statement_descriptor
        @attributes['statement_descriptor']
      end

      # Returns the amount integer
      #
      # @return [Integer]
      def amount_integer
        @attributes['amount'].to_i
      end

      # Returns the amount as a decimal
      #
      # @return [BigDecimal]
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

      # Returns the reconciliation status
      #
      # @return [String]
      def reconciliation_status_value
        @attributes['reconciliation_status']
      end

      # Returns the status value
      #
      # @return [String]
      def status_value
        @attributes['status']
      end

      # Returns the payout status
      #
      # @return [StripePlatform::Models::PayoutStatus]
      def status
        StripePlatform::Models::PayoutStatuses.retrieve(self.status_value)
      end

      # Returns the type value
      #
      # @return [String]
      def type_value
        @attributes['type']
      end

      # Returns the source type value
      #
      # @return [String]
      def source_type_value
        @attributes['source_type']
      end

      # Returns the arrival date unix timestamp
      #
      # @return [Integer]
      def arrival_date_unix_timestamp
        @attributes['arrival_date']
      end

      # Returns the arrival at Time
      #
      # @return [Time,NilClass]
      def arrival_at
        begin
          Time.at(self.arrival_date_unix_timestamp).utc
        rescue
          nil
        end
      end

      # Returns true if there is an arrival at
      #
      # @return [Boolean]
      def arrival_at?
        !self.arrival_at.nil?
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
