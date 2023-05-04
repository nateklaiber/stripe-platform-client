module StripePlatform
  module Requests
    module Models
      class Refund
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :reason            => record_attributes['reason'],
            :amount            => record_attributes['amount'],
            :charge_id         => record_attributes['charge'],
            :payment_intent_id => record_attributes['payment_intent'],
            :metadata          => record_attributes.fetch('metadata', {}),
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def reason
          @attributes[:reason]
        end

        def amount
          @attributes[:amount]
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
            'amount'   => self.amount,
            'reason'   => self.reason,
            'metadata' => self.metadata.as_original_attributes,
          }

          if self.charge?
            attrs.merge!('charge' => self.charge.id)
          end

          if self.payment_intent?
            attrs.merge!('payment_intent' => self.payment_intent.id)
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
