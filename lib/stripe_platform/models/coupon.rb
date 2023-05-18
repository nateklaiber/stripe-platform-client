module StripePlatform
  module Models
    class Coupon

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def name
        @attributes['name']
      end

      def currency_code
        @attributes['currency']
      end

      def duration_value
        @attributes['duration']
      end
      alias duration_id duration_value

      def duration
        @duration ||= StripePlatform::Models::CouponDurations.retrieve(self.duration_value)
      end

      def duration?
        !self.duration.nil?
      end

      def duration_in_months
        @attributes['duration_in_months']
      end

      def max_redemptions
        @atributes['max_redemptions']
      end

      def percent_off_value
        @attributes['percent_off']
      end

      def percent_off_decimal
        begin
          BigDecimal(self.percent_off_value.to_s)
        rescue
          nil
        end
      end

      def amount_off_value
        @attributes['amount_off']
      end

      def amount_off_decimal
        begin
          BigDecimal((self.amount_off_value.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      def amount_off_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.amount_off_decimal.to_f, self.currency_code.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      def times_redeemed
        @attributes['times_redeemed']
      end
      alias times_redeemed_count times_redeemed


      def created_unix_timestamp
        @attributes['created']
      end

      def created_at
        begin
          Time.at(self.created_unix_timestamp)
        rescue
          nil
        end
      end

      def created_at?
        !self.created_at.nil?
      end

      def is_valid
        @attributes['valid']
      end
      alias is_valid? is_valid
      alias valid? is_valid

      def is_livemode
        @attributes['livemode']
      end
      alias is_livemode? is_livemode
      alias livemode? is_livemode

      def to_attributes
        @attributes
      end
    end
  end
end
