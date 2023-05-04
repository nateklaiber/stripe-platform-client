module StripePlatform
  module Requests
    module Models
      class Metadata
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          record_attributes

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def method_missing(method_name, *args)
          if @attributes.has_key?(method_name.to_s)
            @attributes[method_name.to_s]
          end
        end

        def as_original_attributes
          @attributes
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
