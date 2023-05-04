module StripePlatform
  module Models
    class Metadata
      include Comparable

      # Returns an instance of the metadata
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::SetupIntent]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Return the attribute value
      #
      # This is all metadata so we need to inspect
      # the claim
      #
      # @param method_name [String]
      # @param args [Array]
      #
      # @return [String,NilClass]
      def method_missing(method_name, *args)
        if @attributes.has_key?(method_name.to_s)
          @attributes[method_name.to_s]
        end
      end

      # Returns the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
