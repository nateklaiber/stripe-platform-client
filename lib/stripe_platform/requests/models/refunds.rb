module StripePlatform
  module Requests
    module Models
      class Refunds
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :version           => record_attributes['version'],
            :charge_id         => record_attributes['charge'],
            :payment_intent_id => record_attributes['payment_intent'],
            :created           => record_attributes.fetch('created', {}),
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

        def starting_after
          @attributes[:starting_after]
        end

        def ending_before
          @attributes[:ending_before]
        end

        def limit
          @attributes[:limit]
        end

        def created_attributes
          Hash(@attributes.fetch(:created, {}))
        end

        def created
          @created ||= StripePlatform::Requests::Models::TimestampQuery.new(self.created_attributes)
        end

        def charge_id
          @attributes[:charge_id]
        end

        def charge
          @charge ||= StripePlatform::Models::Charges.retrieve(self.charge_id)
        end

        def charge?
          !self.charge.nil?
        end

        def payment_intent_id
          @attributes[:payment_intent_id]
        end

        def payment_intent
          @payment_intent ||= StripePlatform::Models::PaymentIntents.retrieve(self.payment_intent_id)
        end

        def payment_intent?
          !self.payment_intent.nil?
        end

        def as_original_attributes
          attrs = {
            'version'        => self.version,
            'charge'         => nil,
            'payment_intent' => nil,
            'starting_after' => self.starting_after,
            'ending_before'  => self.ending_before,
            'limit'          => self.limit,
            #'created'        => self.created.as_original_attributes,
          }

          if self.charge?
            attrs.merge!('charge' => self.charge.id)
          end

          if self.payment_intent?
            attrs.merge!('payment_intent' => self.payment_intent.id)
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
