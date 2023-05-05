module StripePlatform
  module Requests
    module Models
      class Charge
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :amount            => record_attributes['amount'],
            :currency          => record_attributes['currency'],
            :description       => record_attributes['description'],
            :source_id         => record_attributes['source'],
            :payment_method_id => record_attributes['payment_method'],
            :customer_id       => record_attributes['customer'],
            :metadata          => record_attributes.fetch('metadata', {}),
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def amount
          @attributes[:amount]
        end

        def currency
          @attributes[:currency]
        end

        def description
          @attributes[:description]
        end

        def source_id
          @attributes[:source_id]
        end

        def source
          @source ||= StripePlatform::Models::Tokens.retrieve(self.source_id)
        end

        def source?
          !self.source.nil?
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

        def customer_id
          @attributes[:customer_id]
        end

        def customer
          @customer ||= StripePlatform::Models::Customers.retrieve(self.customer_id)
        end

        def customer?
          !self.customer.nil?
        end

        def metadata_attributes
          Hash(@attributes.fetch(:metadata, {}))
        end

        def metadata
          StripePlatform::Requests::Models::Metadata.new(self.metadata_attributes)
        end

        def address_attributes
          Hash(@attributes.fetch(:address, {}))
        end

        def address
          StripePlatform::Requests::Models::Address.new(self.address_attributes)
        end

        def as_original_attributes
          attrs = {
            'amount'      => self.amount,
            'currency'    => self.currency,
            'description' => self.description,
            'metadata'    => self.metadata.as_original_attributes,
          }

          if self.customer?
            attrs.merge!('customer' => self.customer.id)
          end

          if self.source?
            attrs.merge!('source' => self.source.id)
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
