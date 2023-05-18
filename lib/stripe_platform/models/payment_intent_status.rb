module StripePlatform
  module Models
    class PaymentIntentStatus

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def description
        @attributes['description']
      end

      def requires_payment_method?
        'requires_payment_method' == self.id
      end

      def requires_action?
        'requires_action' == self.id
      end

      def to_attributes
        @attributes
      end
    end
  end
end
