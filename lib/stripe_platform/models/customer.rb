module StripePlatform
  module Models
    class Customer
      include Comparable

      # Returns an instance of the customer
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Customer]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the id
      #
      # @return [String]
      def id
        @attributes['id']
      end

      # Returns the object
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

      # Returns the name
      #
      # @return [String]
      def name
        @attributes['name']
      end

      # Returns the email
      #
      # @return [String]
      def email
        @attributes['email']
      end

      # Returns the phone
      #
      # @return [String]
      def phone
        @attributes['phone']
      end

      # Returns the invoice prefix
      #
      # @return [String]
      def invoice_prefix
        @attributes['invoice_prefix']
      end

      # Returns the next invoice sequence
      #
      # @return [Integer]
      def next_invoice_sequence
        @attributes['next_invoice_sequence']
      end

      # Returns the invoice settings attributes
      #
      # @return [Hash]
      def invoice_settings_attributes
        Hash(@attributes.fetch('invoice_settings', {}))
      end

      # Returns the address attributes
      #
      # @return [Hash]
      def address_attributes
        Hash(@attributes.fetch('address', {}))
      end

      # Returns true if there are any address attributes
      #
      # @return [Boolean]
      def address_attributes?
        !self.address_attributes.empty?
      end

      # Returns the associated address object
      #
      # @return [StripePlatform::Models::Address,NilClass]
      def address
        if self.address_attributes?
          StripePlatform::Models::Address.new(self.address_attributes)
        end
      end

      # Returns true if there is an address
      #
      # @return [Boolean]
      def address?
        !self.address.nil?
      end

      # Returns the currency code
      #
      # @return [String]
      def currency_code
        @attributes['currency']
      end

      # Returns the balance integer
      #
      # @return [Integer]
      def balance_integer
        @attributes['balance'].to_i
      end

      # Returns the balance decimal
      #
      # @return [BigDecimal]
      def balance_decimal
        begin
          BigDecimal((self.balance_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      # Returns the balance unit
      #
      # @return [StripePlatform::Unit,NilClass]
      def balance_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.balance_decimal, self.currency_code.to_s.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      # Returns true if delinquent
      #
      # @return [Boolean]
      def is_delinquent
        @attributes['delinquent']
      end
      alias is_delinquent? is_delinquent
      alias delinquent? is_delinquent

      def metadata_attributes
        Hash(@attributes.fetch('metadata', {}))
      end

      def metadata
        @metadata ||= StripePlatform::Models::Metadata.new(self.metadata_attributes)
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
