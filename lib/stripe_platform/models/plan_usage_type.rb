module StripePlatform
  module Models
    class PlanUsageType

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def description
        @attributes['description']
      end

      def is_default
        @attributes['is_default']
      end
      alias is_default? is_default
      alias default? is_default

      def to_attributes
        @attributes
      end
    end
  end
end
