module StripePlatform
  module Models
    class CustomField
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def name
        @attributes['name']
      end

      def value
        @attributes['value']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
