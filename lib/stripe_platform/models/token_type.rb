module StripePlatform
  module Models
    class TokenType

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def description
        @attributes['description']
      end

      def object_for(record_attributes)
        case(self.id)
        when('card')
          StripePlatform::Models::Card.new(record_attributes)
        end
      end

      def to_attributes
        @attributes
      end
    end
  end
end
