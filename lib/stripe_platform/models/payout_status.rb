module StripePlatform
  module Models
    class PayoutStatus

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def description
        @attributes['description']
      end

      def paid?
        'paid' == self.id
      end

      def pending?
        'pending' == self.id
      end

      def in_transit?
        'in_transit' == self.id
      end

      def canceled?
        'canceled' == self.id
      end

      def failed?
        'failed' == self.id
      end

      def to_attributes
        @attributes
      end
    end
  end
end
