module StripePlatform
  module Models
    class SubscriptionStatus

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def description
        @attributes['description']
      end

      def active?
        'active' == self.id
      end

      def past_due?
        'past_due' == self.id
      end

      def unpaid?
        'unpaid' == self.id
      end

      def canceled?
        'canceled' == self.id
      end

      def incomplete?
        'incomplete' == self.id
      end

      def incomplete_expired?
        'incomplete_expired' == self.id
      end

      def trialing?
        'trialing' == self.id
      end

      def paused?
        'paused' == self.id
      end

      def all?
        'all' == self.id
      end

      def ended?
        'ended' == self.id
      end

      def to_attributes
        @attributes
      end
    end
  end
end
