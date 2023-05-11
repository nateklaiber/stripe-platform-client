module StripePlatform
  module Models
    class RoundDirection

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def description
        @attributes['description']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
