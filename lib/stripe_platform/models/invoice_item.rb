module StripePlatform
  module Models
    class InvoiceItem

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

      def description
        @attributes['description']
      end

      def invoice_value
        @attributes['invoice']
      end

      def invoice_id
        if self.invoice_value.is_a?(String)
          self.invoice_value
        end
      end

      def invoice_id?
        !self.invoice_id.nil?
      end

      def invoice_attributes
        if self.invoice_value.is_a?(Hash)
          Hash(self.invoice_value)
        else
          {}
        end
      end

      def invoice_attributes?
        !self.invoice_attributes.empty?
      end

      def invoice
        @invoice ||= if self.invoice_attributes?
                        StripePlatform::Models::Invoice.new(self.invoice_attributes)
                      else
                        StripePlatform::Models::Invoices.retrieve(self.invoice_id)
                      end
      end

      def invoice?
        !self.invoice.nil?
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
        !self.subscription_attributes.empty?
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

      def customer_value
        @attributes['customer']
      end

      def customer_id
        if self.customer_value.is_a?(String)
          self.customer_value
        end
      end

      def customer_id?
        !self.customer_id.nil?
      end

      def customer_attributes
        if self.customer_value.is_a?(Hash)
          Hash(self.customer_value)
        else
          {}
        end
      end

      def customer_attributes?
        !self.customer_attributes.empty?
      end

      def customer
        @customer ||= if self.customer_attributes?
                        StripePlatform::Models::Customer.new(self.customer_attributes)
                      else
                        StripePlatform::Models::Customers.retrieve(self.customer_id)
                      end
      end

      def customer?
        !self.customer.nil?
      end

      def subscription_item_value
        @attributes['subscription_item']
      end

      def subscription_item_id
        if self.subscription_item_value.is_a?(String)
          self.subscription_item_value
        end
      end

      def subscription_item_id?
        !self.subscription_item_id.nil?
      end

      def subscription_item
        @subscription_item ||= StripePlatform::Models::SubscriptionItems.retrieve(self.subscription_item_id)
      end

      def subscription_item?
        !self.subscription_item.nil?
      end

      def period_attributes
        Hash(@attributes.fetch('period', {}))
      end
      alias time_period_attributes period_attributes

      def period
        @period ||= StripePlatform::Models::TimePeriod.new(self.period_attributes)
      end
      alias time_period period

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

      def currency_code
        @attributes['currency']
      end

      def amount_integer
        @attributes['amount'].to_i
      end

      def amount_decimal
        begin
          BigDecimal((self.amount_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

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

      def unit_amount_integer
        @attributes['unit_amount'].to_i
      end

      def unit_amount_decimal
        begin
          BigDecimal((self.unit_amount_integer.to_f / 100.0).to_s)
        rescue
          nil
        end
      end

      def unit_amount_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.unit_amount_decimal, self.currency_code.upcase]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      def date_unix_timestamp
        @attributes['date']
      end

      def date
        begin
          Time.at(self.date_unix_timestamp)
        rescue
          nil
        end
      end
      alias created_at date

      def date?
        !self.date.nil?
      end
      alias created_at? date

      def quantity
        @attributes['quantity']
      end
      alias quantity_count quantity

      def is_livemode
        @attributes['livemode']
      end
      alias is_livemode? is_livemode
      alias livemode? is_livemode

      def is_proration
        @attributes['proration']
      end
      alias is_proration? is_proration
      alias proration? is_proration

      def is_discountable
        @attributes['discountable']
      end
      alias is_discountable? is_discountable
      alias discountable? is_discountable

      def to_attributes
        @attributes
      end
    end
  end
end
