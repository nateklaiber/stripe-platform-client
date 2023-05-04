module StripePlatform
  module Requests
    module Models
      class PaymentMethod
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :type_id         => record_attributes['type'],
            :card            => record_attributes.fetch('card', {}),
            :billing_details => record_attributes.fetch('billing_details', {})
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def type_id
          @attributes[:type_id]
        end

        def type
          StripePlatform::Models::PaymentMethodTypes.retrieve(self.type_id)
        end

        def type?
          !self.type.nil?
        end

        def card_attributes
          Hash(@attributes.fetch(:card, {}))
        end

        def card
          StripePlatform::Requests::Models::Card.new(self.card_attributes)
        end

        def billing_details_attributes
          Hash(@attributes.fetch(:billing_details, {}))
        end

        def billing_details
          StripePlatform::Requests::Models::BillingDetails.new(self.billing_details_attributes)
        end

        def as_original_attributes
          attrs = {
            'type'            => nil,
            'card'            => self.card.as_original_attributes,
            'billing_details' => self.billing_details.as_original_attributes,
          }

          if self.type?
            attrs.merge!('type' => self.type.id)
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
