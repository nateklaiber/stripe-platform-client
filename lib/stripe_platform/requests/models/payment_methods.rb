module StripePlatform
  module Requests
    module Models
      class PaymentMethods
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :version           => record_attributes['version'],
            :type              => record_attributes['type'],
            :customer_id       => record_attributes['customer'],
            :ending_before     => record_attributes['ending_before'],
            :starting_after    => record_attributes['starting_after'],
            :limit             => record_attributes['limit'],
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def version
          @attributes[:version]
        end

        def type
          @attributes[:type]
        end

        def starting_after
          @attributes[:starting_after]
        end

        def ending_before
          @attributes[:ending_before]
        end

        def limit
          @attributes[:limit]
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

        def as_original_attributes
          attrs = {
            'version'        => self.version,
            'type'           => self.type,
            'customer'         => nil,
            'starting_after' => self.starting_after,
            'ending_before'  => self.ending_before,
            'limit'          => self.limit,
          }

          if self.customer?
            attrs.merge!('customer' => self.customer.id)
          end

          attrs
        end

        def as_query_attributes
          self.as_original_attributes
        end

        def as_form_encoded_attributes
          self.as_original_attributes
        end

        def as_form_encoded
          Rack::Utils.build_nested_query(self.as_form_encoded_attributes)
        end

        def as_query_encoded
          Rack::Utils.build_nested_query(self.as_query_attributes)
        end

        def as_json(*)
          self.as_original_attributes
        end
      end
    end
  end
end
