module StripePlatform
  module Models
    class EventData

      # Returns an instance of the event data
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
      alias type_id type_value

      def type
        @type ||= StripePlatform::Models::EventTypes.retrieve(self.type_value)
      end

      def type?
        !self.type.nil?
      end

      def object_attributes
        Hash(@attributes.fetch('object', {}))
      end

      def object
        self.type.object_for(self.object_attributes)
      end

      def previous_attributes_attributes
        Hash(@attributes.fetch('previous_attributes', {}))
      end

      def to_attributes
        @attributes
      end
    end
  end
end
