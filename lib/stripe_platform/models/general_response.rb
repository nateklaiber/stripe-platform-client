module StripePlatform
  module Models
    class GeneralResponse

      # Returns an instance of the general response
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::GeneralResponse]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the object name
      #
      # @return [String]
      def object
        @attributes['object']
      end

      # Returns the raw data attributes
      #
      # @return [Array,Hash]
      def data_attributes
        @attributes['data']
      end

      # Returns true if there are data attributes
      #
      # @return [Boolean]
      def data_attributes?
        @attributes.has_key?('data')
      end

      # Returns the data structure
      #
      # @return [Array,Hash]
      def data
        if self.data_attributes?
          if self.data_attributes.kind_of?(Array)
            Array(self.data_attributes)
          elsif self.data_attributes.kind_of?(Hash)
            Hash(self.data_attributes)
          else
            self.data_attributes
          end
        else
          nil
        end
      end

      # Returns true if there was any data
      #
      # @return [Boolean]
      def data?
        !self.data.nil?
      end

      # Returns the count of records
      #
      # @return [Integer]
      def count
        @attributes['count']
      end

      # Returns true if there are more records
      #
      # @return [Boolean]
      def has_more
        @attributes['has_more']
      end
      alias has_more? has_more
      alias more? has_more

      # Returns the URL
      #
      # This is technically a path, but want to keep
      # consistent with the attribute name
      #
      # @return [String]
      def url
        @attributes['url']
      end
    end
  end
end
