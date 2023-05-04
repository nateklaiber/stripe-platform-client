module StripePlatform
  module Models
    class PaymentIntent
      include Comparable

      # Returns an instance of the setup intent
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::PaymentIntent]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the id
      #
      # @return [String]
      def id
        @attributes['id']
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

      def object
        @attributes['object']
      end

      def application
        @attributes['application']
      end

      def capture_method
        @attributes['capture_method']
      end

      def client_secret
        @attributes['client_secret']
      end

      def confirmation_method
        @attributes['confirmation_method']
      end

      def description
        @attributes['description']
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

      def latest_charge_id
        @attributes['latest_charge']
      end

      def latest_charge
        @latest_charge ||= StripePlatform::Models::Charges.retrieve(self.latest_charge_id)
      end

      def latest_charge?
        !self.latest_charge.nil?
      end

      def metadata_attributes
        Hash(@attributes.fetch('metadata', {}))
      end

      def metadata
        @metadata ||= StripePlatform::Models::Metadata.new(self.metadata_attributes)
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

      def statement_descriptor
        @attributes['statement_descriptor']
      end

      def statement_descriptor_suffix
        @attributes['statement_descriptor_suffix']
      end

      def status_value
        @attributes['status']
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

      def to_attributes
        @attributes
      end
    end
  end
end
