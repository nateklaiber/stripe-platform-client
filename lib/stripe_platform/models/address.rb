module StripePlatform
  module Models
    class Address
      include Comparable

      # Returns an instance of the address
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Address]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def city
        @attributes['city']
      end
      alias locality city

      def country_code
        @attributes['country']
      end

      def line_1
        @attributes['line1']
      end

      def line_2
        @attributes['line2']
      end

      def postal_code
        @attributes['postal_code']
      end
      alias zip postal_code
      alias zip_code postal_code

      def state
        @attributes['state']
      end
      alias region state
      alias province region

      def to_attributes
        @attributes
      end
    end
  end
end
