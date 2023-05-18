module StripePlatform
  module Models
    class UsBankAccount

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def account_holder_type_value
        @attributes['account_holder_type']
      end

      def account_type_value
        @attributes['account_type']
      end

      def bank_name
        @attributes['bank_name']
      end

      def routing_number
        @attributes['routing_number']
      end

      def last_4
        @attributes['last4']
      end
      alias last4 last_4

      def fingerprint
        @attributes['fingerprint']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
