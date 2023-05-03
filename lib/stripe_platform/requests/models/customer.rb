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
            :metadata    => record_attributes.fetch('metadata', {}),
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
        end

        def as_original_attributes
          {
            'email'       => self.email,
            'name'        => self.name,
            'phone'       => self.phone,
            'description' => self.description,
          }
        end

        def as_json(*)
          self.as_original_attributes
        end
      end
    end
  end
end
