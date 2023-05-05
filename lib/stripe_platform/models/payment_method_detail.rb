module StripePlatform
  module Models
    class PaymentMethodDetail
      extend Forwardable

      # Returns an instance of the charge
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::BalanceTransaction]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def type_value
        @attributes['type']
      end

      def data_attributes
        case(self.type_value)
        when('card')
          Hash(@attributes.fetch('card', {}))
        end
      end

      def source
        case(self.type_value)
        when('card')
          StripePlatform::Models::Card.new(self.data_attributes)
        end
      end

      def to_attributes
        @attributes
      end
    end
  end
end
