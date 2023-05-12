module StripePlatform
  module Models
    class RecurringProfile

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def aggregate_usage_value
        @attributes['aggregate_usage']
      end
      alias aggregate_usage_id aggregate_usage_value

      def aggregate_usage
        @aggregate_usage ||= StripePlatform::Models::AggregateUsageTypes.retrieve(self.aggregate_usage_value)
      end

      def aggregate_usage?
        !self.aggregate_usage.nil?
      end

      def interval_value
        @attributes['interval']
      end
      alias interval_id interval_value

      def interval
        @interval ||= StripePlatform::Models::BillingIntervals.retrieve(self.interval_value)
      end
      alias billing_interval interval

      def interval_count
        @attributes['interval_count']
      end

      def trial_period_days
        @attributes['trial_period_days']
      end

      def usage_type_value
        @attributes['usage_type']
      end
      alias usage_type_id usage_type_value

      def usage_type
        @usage_type ||= StripePlatform::Models::PlanUsageTypes.retrieve(self.usage_type_value)
      end

      def usage_type?
        !self.usage_type.nil?
      end

      def to_attributes
        @attributes
      end
    end
  end
end
