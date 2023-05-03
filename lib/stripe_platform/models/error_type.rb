module StripePlatform
  module Models
    class ErrorType

      # Returns an instance of the error type
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::ErrorType]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      # Returns the id
      #
      # @return [String]
      def id
        @attributes['id']
      end

      # Returns the description
      #
      # @return [String]
      def description
        @attributes['description']
      end

      # Returns the exception class for the
      # corresponding type
      #
      # @return [Object]
      def exception_class
        case(self.id)
        when('api_error')
          StripePlatform::Errors::ApiError
        when('card_error')
          StripePlatform::Errors::CardError
        when('idempotency_error')
          StripePlatform::Errors::IdempotencyError
        when('invalid_request_error')
          StripePlatform::Errors::InvalidRequestError
        end
      end

      # Raises the exception with the supplied message
      #
      # @raises [StandardError]
      def raise_exception!(message)
        raise self.exception_class.new(message)
      end

      # Returns true if this is an api error
      #
      # @return [Boolean]
      def api_error?
        'api_error' == self.id
      end

      # Returns true if this is a card error
      #
      # @return [Boolean]
      def card_error?
        'card_error' == self.id
      end

      # Returns true if this is an idempotency error
      #
      # @return [Boolean]
      def idempotency_error?
        'idempotency_error' == self.id
      end

      # Returns true if this is an invalid request error
      #
      # @return [Boolean]
      def invalid_request_error?
        'invalid_request_error' == self.id
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
