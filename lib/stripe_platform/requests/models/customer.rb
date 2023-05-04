module StripePlatform
  module Requests
    module Models
      class Customer
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :description => record_attributes['description'],
            :name        => record_attributes['name'],
            :email       => record_attributes['email'],
            :phone       => record_attributes['phone'],
            :phone       => record_attributes['phone'],
            :metadata    => record_attributes.fetch('metadata', {}),
            :address     => record_attributes.fetch('address', {}),
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def description
          @attributes[:description]
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
          {
            'email'       => self.email,
            'name'        => self.name,
            'phone'       => self.phone,
            'description' => self.description,
            'address'     => self.address.as_original_attributes,
            'metadata'    => self.metadata.as_original_attributes,
          }
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
