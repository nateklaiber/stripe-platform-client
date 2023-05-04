module StripePlatform
  module Requests
    module Models
      class PaymentIntent
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :statement_descriptor         => record_attributes['statement_descriptor'],
            :confirm         => record_attributes['confirm'],
            :off_session         => record_attributes['off_session'],
            :description         => record_attributes['description'],
            :amount         => record_attributes['amount'],
            :currency_code         => record_attributes['currency'],
            :usage         => record_attributes['usage'],
            :customer_id         => record_attributes['customer'],
            :payment_method_id         => record_attributes['payment_method'],
            :metadata         => record_attributes.fetch('metadata', {})
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def statement_descriptor
          @attributes[:statement_descriptor]
        end

        def confirm
          @attributes[:confirm]
        end

        def description
          @attributes[:description]
        end

        def amount
          @attributes[:amount]
        end

        def currency_code
          @attributes[:currency_code]
        end

        def off_session
          @attributes[:off_session]
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

        def metadata_attributes
          Hash(@attributes.fetch(:metadata, {}))
        end

        def metadata
          StripePlatform::Requests::Models::Metadata.new(self.metadata_attributes)
        end

        def as_original_attributes
          attrs = {
            'statement_descriptor'            => self.off_session,
            'off_session'            => self.off_session,
            'confirm'            => self.confirm,
            'amount'            => self.amount,
            'currency'            => self.currency_code,
            'description'            => self.description,
            'customer'            => nil,
            'payment_method'            => nil,
            'metadata'            => self.metadata.as_original_attributes,
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
