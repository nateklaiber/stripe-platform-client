module StripePlatform
  module Models
    class Subscription
      extend Forwardable

      def_delegator :status, :active?, :status_active?
      def_delegator :status, :incomplete?, :status_incomplete?

      def_delegator :collection_method, :charge_automatically?
      def_delegator :collection_method, :send_invoice?

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def status_value
        @attributes['status']
      end
      alias status_id status_value

      def status
        @status ||= StripePlatform::Models::SubscriptionStatuses.retrieve(self.status_value)
      end

      def status?
        !self.status.nil?
      end

      def description
        @attributes['description']
      end

      def metadata_attributes
        Hash(@attributes.fetch('metadata', {}))
      end

      def metadata
        @metadata ||= StripePlatform::Models::Metadata.new(self.metadata_attributes)
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

      def currency_code
        @attributes['currency']
      end

      def items_attributes
        Hash(@attributes.fetch('items', {}))
      end

      def customer_value
        @attributes['customer']
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

      def customer_id
        if self.customer_value.is_a?(String)
          self.customer_value
        end
      end

      def customer_id?
        !self.customer_id.nil?
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

      def latest_invoice_value
        @attributes['latest_invoice']
      end

      def latest_invoice_attributes
        if self.latest_invoice_value.is_a?(Hash)
          Hash(self.latest_invoice_value)
        else
          {}
        end
      end

      def latest_invoice_attributes?
        !self.latest_invoice_attributes.empty?
      end

      def latest_invoice_id
        if self.latest_invoice_value.is_a?(String)
          self.latest_invoice_value
        end
      end

      def latest_invoice_id?
        !self.latest_invoice_id.nil?
      end

      def latest_invoice
        @latest_invoice ||= if self.latest_invoice_attributes?
                        StripePlatform::Models::Invoice.new(self.latest_invoice_attributes)
                      else
                        StripePlatform::Models::Invoices.retrieve(self.latest_invoice_id)
                      end
      end

      def latest_invoice?
        !self.latest_invoice.nil?
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

      def current_period_start_unix_timestamp
        @attributes['current_period_start']
      end

      def current_period_start_at
        begin
          Time.at(self.current_period_start_unix_timestamp).utc
        rescue
          nil
        end
      end

      def current_period_start_at?
        !self.current_period_start_at.nil?
      end

      def current_period_end_unix_timestamp
        @attributes['current_period_end']
      end

      def current_period_end_at
        begin
          Time.at(self.current_period_end_unix_timestamp).utc
        rescue
          nil
        end
      end

      def current_period_end_at?
        !self.current_period_end_at.nil?
      end

      def billing_cycle_anchor_unix_timestamp
        @attributes['billing_cycle_anchor']
      end

      def billing_cycle_anchor_at
        begin
          Time.at(self.billing_cycle_anchor_unix_timestamp).utc
        rescue
          nil
        end
      end

      def billing_cycle_anchor_at?
        !self.billing_cycle_anchor_at.nil?
      end

      def is_active
        self.status_active?
      end
      alias is_active? is_active
      alias active? is_active

      def is_livemode
        @attributes['livemode']
      end
      alias is_livemode? is_livemode
      alias livemode? is_livemode

      def has_payment_method?
        !((self.status? && self.status.incomplete?) && (self.latest_invoice? && self.latest_invoice.payment_intent? && self.latest_invoice.payment_intent.status? && self.latest_invoice.payment_intent.status.has_payment_method?))
      end

      # Returns the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
