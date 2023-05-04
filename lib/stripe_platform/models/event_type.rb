module StripePlatform
  module Models
    class EventType

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
        when('charge.refunded')
          StripePlatform::Models::Refund.new(record_attributes)
        end
      end

      def to_attributes
        @attributes
      end
    end
  end
end
