module StripePlatform
  module Models
    class Invoice

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
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

      def subscription_attributes
        if self.subscription_value.is_a?(Hash)
          Hash(self.subscription_value)
        else
          {}
        end
      end

      def subscription_attributes?
        !self.subscription_attributes.nil?
      end

      def subscription
        @subscription ||= if self.subscription_attributes?
                            StripePlatform::Models::Subscription.new(self.subscription_attributes)
                          else
                            StripePlatform::Models::Subscriptions.retrieve(self.subscription_id)
                          end
      end

      def subscription?
        !self.subscription.nil?
      end

      def number
        @attributes['number']
      end

      def object
        @attributes['object']
      end

      def billing_reason_value
        @attributes['billing_reason']
      end

      def collection_method_value
        @attributes['collection_method']
      end
      alias collection_method_id collection_method_value

      def collection_method
        @collection_method ||= StripePlatform::Models::CollectionMethods.retrieve(self.collection_method_value)
      end

      def collection_method?
        !self.collection_method.nil?
      end

      def currency
        @attributes['currency']
      end

      def account_name
        @attributes['account_name']
      end

      def account_country
        @attributes['account_country']
      end

      def lines_attributes
        Hash(@attributes.fetch('lines', {}))
      end

      def attempt_count
        @attributes['attempt_count']
      end

      def is_attempted
        @attributes['attempted']
      end
      alias is_attempted? is_attempted
      alias attempted? is_attempted

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

      def status_value
        @attributes['status']
      end
      alias status_id status_value

      def status
        @status ||= StripePlatform::Models::InvoiceStatuses.retrieve(self.status_value)
      end

      def status?
        !self.status.nil?
      end

      def is_livemode
        @attributes['livemode']
      end
      alias is_livemode? is_livemode
      alias livemode? is_livemode

      def is_paid
        @attributes['paid']
      end
      alias is_paid? is_paid
      alias paid? is_paid

      def to_attributes
        @attributes
      end
    end
  end
end
