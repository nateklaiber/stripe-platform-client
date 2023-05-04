module StripePlatform
  module Models
    class ChargeStatus

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def description
        @attributes['description']
      end

      def succeeded?
        'succeeded' == self.id
      end

      def pending?
        'pending' == self.id
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
