module StripePlatform
  module Requests
    module Models
      class SetupIntent
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :confirm         => record_attributes['confirm'],
            :description         => record_attributes['description'],
            :usage         => record_attributes['usage'],
            :customer_id         => record_attributes['customer'],
            :payment_method_id         => record_attributes['payment_method'],
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def confirm
          @attributes[:confirm]
        end

        def description
          @attributes[:description]
        end

        def usage
          @attributes[:usage]
        end

        def customer_id
          @attributes[:customer_id]
        end

        def customer
          @customer ||= StripePlatform::Models::Customers.retrieve(self.customer_id)
        end

        def customer?
          !self.customer.nil?
        end

        def payment_method_id
          @attributes[:payment_method_id]
        end

        def payment_method
          @payment_method ||= StripePlatform::Models::PaymentMethods.retrieve(self.payment_method_id)
        end

        def payment_method?
          !self.payment_method.nil?
        end


        def as_original_attributes
          attrs = {
            'confirm'            => self.confirm,
            'description'            => self.description,
            'usage'            => self.usage,
            'customer'            => nil,
            'payment_method'            => nil,

          }

          if self.customer?
            attrs.merge!('customer' => self.customer.id)
          end

          if self.payment_method?
            attrs.merge!('payment_method' => self.payment_method.id)
          end

          attrs
        end

        def as_form_encoded_attributes
          self.as_original_attributes
        end

        def as_form_encoded
          Rack::Utils.build_nested_query(self.as_form_encoded_attributes)
        end

        def as_json(*)
          self.as_original_attributes
        end
      end
    end
  end
end
