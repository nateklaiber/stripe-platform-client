module StripePlatform
  module Models
    class SetupIntent
      include Comparable

      # Returns an instance of the setup intent
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::SetupIntent]
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
        StripePlatform::Models::Customers.retrieve(self.customer_id)
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

      def client_secret
        @attributes['client_secret']
      end

      def description
        @attributes['description']
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

      def status_value
        @attributes['status']
      end

      def usage_value
        @attributes['usage']
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
