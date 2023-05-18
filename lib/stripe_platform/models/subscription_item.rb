module StripePlatform
  module Models
    class SubscriptionItem

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def metadata_attributes
        Hash(@attributes.fetch('metadata', {}))
      end

      def metadata
        @metadata ||= StripePlatform::Models::Metadata.new(self.metadata_attributes)
      end

      def subscription_value
        @attributes['subscription']
      end

      def subscription_id
        if self.subscription_value.is_a?(String)
          self.subscription_value
        end
      end

      def subscription_id?
        !self.subscription_id.nil?
      end

      def subscription
        @subscription ||= StripePlatform::Models::Subscriptions.retrieve(self.subscription_id)
      end

      def subscription?
        !self.subscription.nil?
      end

      def quantity
        @attributes['quantity']
      end
      alias quantity_count quantity

      def plan_attributes
        Hash(@attributes.fetch('plan', {}))
      end

      def plan
        @plan ||= StripePlatform::Models::Plan.new(self.plan_attributes)
      end

      def price_attributes
        Hash(@attributes.fetch('price', {}))
      end

      def price
        @price ||= StripePlatform::Models::Price.new(self.price_attributes)
      end

      def created_unix_timestamp
        @attributes['created']
      end

      def created_at
        begin
          Time.at(self.created_unix_timestamp).utc
        rescue
          nil
        end
      end

      def created_at?
        !self.created_at.nil?
      end

      def to_attributes
        @attributes
      end
    end
  end
end
