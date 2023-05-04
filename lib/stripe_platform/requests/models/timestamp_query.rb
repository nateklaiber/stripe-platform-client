module StripePlatform
  module Requests
    module Models
      class TimestampQuery
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :gt  => record_attributes['gt'],
            :gte => record_attributes['gte'],
            :lt  => record_attributes['lt'],
            :lte => record_attributes['lte'],
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def lt
          @attributes[:lt]
        end

        def lte
          @attributes[:lte]
        end

        def gt
          @attributes[:gt]
        end

        def gte
          @attributes[:gte]
        end


        def as_original_attributes
          attrs = {
            'lt'  => self.lt,
            'lte' => self.lte,
            'gt'  => self.gt,
            'gte' => self.gte,
          }

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
