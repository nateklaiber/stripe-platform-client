module StripePlatform
  module Models
    class Customer
      include Comparable
      extend Forwardable


      # Returns an instance of the customer
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Customer]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end
    end
  end
end
