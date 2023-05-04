module StripePlatform
  module Requests
    module Models
      class BillingDetails
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :email   => record_attributes['email'],
            :name    => record_attributes['name'],
            :phone   => record_attributes['phone'],
            :address => record_attributes.fetch('address', {})
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def email
          @attributes[:email]
        end

        def name
          @attributes[:name]
        end

        def phone
          @attributes[:phone]
        end

        def address_attributes
          Hash(@attributes.fetch(:address, {}))
        end

        def address
          StripePlatform::Requests::Models::Address.new(self.address_attributes)
        end

        def as_original_attributes
          {
            'name'    => self.name,
            'email'   => self.email,
            'phone'   => self.phone,
            'address' => self.address.as_original_attributes,
          }
        end

        def as_form_encoded_attributes
          self.as_original_attributes
        end

        def as_form_encoded
          Rack::Utils.build_nested_query(self.as_original_attributes)
        end

        def as_json(*)
          self.as_original_attributes
        end
      end
    end
  end
end
