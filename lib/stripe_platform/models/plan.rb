module StripePlatform
  module Models
    class Plan

      # Returns an instance of the charge
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Refund]
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

      def product_id
        @attributes['product']
      end

      def product
        StripePlatform::Models::Products.retrieve(self.product_id)
      end

      def product?
        !self.product.nil?
      end

      def nickname
        @attributes['nickname']
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

      def billing_scheme_value
        @attributes['billing_scheme']
      end
      alias billing_scheme_id billing_scheme_value

      def billing_scheme
        @billing_scheme ||= StripePlatform::Models::BillingSchemes.retrieve(self.billing_scheme_value)
      end

      def billing_scheme?
        !self.billing_scheme.nil?
      end

      def tiers_mode_value
        @attributes['tiers_mode']
      end
      alias tiers_mode_id tiers_mode_value

      def tiers_mode
        @tiers_mode ||= StripePlatform::Models::PricingTiersModes.retrieve(self.tiers_mode_value)
      end
      alias pricing_tiers_mode tiers_mode

      def tiers_mode?
        !self.tiers_mode.nil?
      end
      alias pricing_tiers_mode? tiers_mode?

      def tiers_attributes
        Array(@attributes.fetch('tiers', []))
      end

      def original_resolved_tiers_attributes
        self.tiers_attributes.map { |r| r.merge!('tiers_mode' => self.tiers_mode_value, 'currency' => self.currency_code) }
      end

      def sorted_tiers_attributes
        self.tiers_attributes.sort do |a,b|
          [a['up_to'] ? 0 : 1, a['up_to']] <=> [b['up_to'] ? 0 : 1, b['up_to']]
        end
      end

      # This resolves and injects the full range, not just the 'up_to'
      #
      # We want to be able to find a price for a specific number, which
      # means we need upper and lower bounds. Stripe does not supply this.
      #
      # @return [Array]
      def resolved_tiers_attributes
        resolved_records = []

        range_memo = {}
        range_memo[:start] = 0
        range_memo[:end]   = nil

        self.sorted_tiers_attributes.each_with_index.inject(resolved_records) do |col, (tier_attributes,idx)|
          record_attributes = tier_attributes
          record_attributes.merge!('index' => (idx + 1))
          record_attributes.merge!('tiers_mode' => self.tiers_mode_value)
          record_attributes.merge!('currency' => self.currency_code)

          if !tier_attributes['up_to'].nil?
            if idx == 0
              record_attributes.merge!('up_from' => 1)
              record_attributes.merge!('start_at' => 1)
              record_attributes.merge!('end_at' => tier_attributes['up_to'])

              range_memo[:start] = 1
              range_memo[:end] = tier_attributes['up_to']
            else
              up_from = (range_memo[:end] + 1)

              record_attributes.merge!('up_from' => up_from)
              record_attributes.merge!('start_at' => up_from)
              record_attributes.merge!('end_at' => tier_attributes['up_to'])

              range_memo[:start] = up_from
              range_memo[:end] = tier_attributes['up_to']
            end
          else
            up_from = (range_memo[:end] + 1)

            record_attributes.merge!('up_from' => up_from)
            record_attributes.merge!('start_at' => up_from)
            record_attributes.merge!('end_at' => tier_attributes['up_to'])

            range_memo[:start] = up_from
            range_memo[:end] = tier_attributes['up_to']
          end

          col.push(record_attributes)

          col
        end

        resolved_records
      end

      def tiers
        @tiers ||= StripePlatform::Models::PricingTiers.new(self.resolved_tiers_attributes)
      end
      alias pricing_tiers tiers

      def tiers?
        self.tiers.any?
      end
      alias pricing_tiers? tiers?

      def transform_usage_attributes
        Hash(@attributes.fetch('transform_usage', {}))
      end

      def transform_usage
        @transform_usage ||= StripePlatform::Models::TransformUsage.new(self.transform_usage_attributes)
      end

      def transform_usage?
        self.transform_usage.any?
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

      # Returns the currency code
      #
      # @return [String]
      def currency_code
        @attributes['currency']
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

      # Returns the amount as an integer
      #
      # @return [Integer]
      def amount_integer
        @attributes['amount'].to_i
      end

      # Returns the amount as a decimal
      #
      # @return [BigDecimal,NilClass]
      def amount_decimal
        begin
          BigDecimal((self.amount_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      # Returns the amount unit
      #
      # @return [StripePlatform::Unit]
      def amount_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.amount_decimal, self.currency_code.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
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

      def is_active
        @attributes['active']
      end
      alias is_active? is_active
      alias active? is_active

      # Returns the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
