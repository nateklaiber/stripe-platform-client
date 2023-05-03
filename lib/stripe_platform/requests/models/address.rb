module StripePlatform
  module Requests
    module Models
      class Address
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :city        => record_attributes['city'],
            :country     => record_attributes['country'],
            :line_1      => record_attributes['line1'],
            :line_2      => record_attributes['line2'],
            :postal_code => record_attributes['postal_code'],
            :state       => record_attributes['state'],
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def city
          @attributes[:city]
        end

        def country
          @attributes[:country]
        end

        def line_1
          @attributes[:line_1]
        end

        def line_2
          @attributes[:line_2]
        end

        def postal_code
          @attributes[:postal_code]
        end

        def state
          @attributes[:state]
        end

        def as_original_attributes
          {
            'city'        => self.city,
            'country'     => self.country,
            'line1'       => self.line_1,
            'line2'       => self.line_2,
            'postal_code' => self.postal_code,
            'state'       => self.state,
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
