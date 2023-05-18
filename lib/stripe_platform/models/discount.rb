module StripePlatform
  module Models
    class Discount

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def coupon_attributes
        Hash(@attributes.fetch('coupon', {}))
      end

      def coupon
        @coupon ||= StripePlatform::Models::Coupon.new(self.coupon_attributes)
      end

      def invoice_item_value
        @attributes['invoice_item']
      end

      def invoice_item_id
        if self.invoice_item_value.is_a?(String)
          self.invoice_item_value
        end
      end

      def invoice_item_id?
        !self.invoice_item_id.nil?
      end

      def invoice_item
        @invoice_item ||= if self.invoice_item_id?
                            StripePlatform::Models::InvoiceItems.retrieve(self.invoice_item_id)
                          end
      end

      def invoice_item?
        !self.invoice_item.nil?
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

      def invoice
        @invoice ||= if self.invoice_id?
                       StripePlatform::Models::Invoices.retrieve(self.invoice_id)
                     end
      end

      def invoice?
        !self.invoice.nil?
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

      def end_unix_timestamp
        @attributes['end']
      end

      def end_at
        begin
          Time.at(self.end_unix_timestamp)
        rescue
          nil
        end
      end

      def end_at?
        !self.end_at.nil?
      end

      def start_unix_timestamp
        @attributes['start']
      end

      def start_at
        begin
          Time.at(self.start_unix_timestamp)
        rescue
          nil
        end
      end

      def start_at?
        !self.start_at.nil?
      end

      def to_attributes
        @attributes
      end
    end
  end
end
