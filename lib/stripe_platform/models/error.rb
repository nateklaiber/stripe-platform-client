module StripePlatform
  module Models
    class Error
      extend Forwardable

      def_delegator :type, :api_error?
      def_delegator :type, :card_error?
      def_delegator :type, :idempotency_error?
      def_delegator :type, :invalid_request_error?

      # Returns an instance of the error object
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Error]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the error attributes
      #
      # @return [Hash]
      def error_attributes
        Hash(@attributes.fetch('error', {}))
      end

      # Returns the message
      #
      # @return [String]
      def message
        self.error_attributes['message']
      end

      # Returns the associated param if applicable
      #
      # @return [String]
      def param
        self.error_attributes['param']
      end

      # Returns the request log url value
      #
      # @return [String]
      def request_log_url_value
        self.error_attributes['request_log_url']
      end

      # Returns the request log url
      #
      # @return [StripePlatform::ResourceUri]
      def request_log_url
        StripePlatform::ResourceUri.new(self.request_log_url_value)
      end

      # Returns the type value
      #
      # @return [String]
      def type_value
        self.error_attributes['type']
      end

      # Returns the type record
      #
      # @return [StripePlatform::Models::ErrorType]
      def type
        StripePlatform::Models::ErrorTypes.retrieve(self.type_value)
      end

      # Returns the exception message
      #
      # @return [String]
      def exception_message
        [self.message, self.param].join(' - ')
      end

      # Raise the corresponding exception mapped to the type
      #
      # @note: This comes from the Stripe API documentation
      #
      # @raises [StandardError]
      def raise_exception!
        self.type.raise_exception!(self.exception_message)
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
