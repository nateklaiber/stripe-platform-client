module StripePlatform
  module Models
    class DirectoryEntry < SimpleDelegator
      include Comparable

      # Creates an instance of the directory entry from the routes
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::DirectoryEntry]
      def initialize(attributes={})
        @attributes = Hash(attributes)

        @_record = RestlessRouter::Route.new(@attributes['rel'], @attributes['path'], templated: @attributes['templated'])
      end

      # Implement simple delegator
      #
      # @return [noop]
      def __getobj__
        @_record
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
