module StripePlatform
  module Models
    class Invoice

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def to_attributes
        @attributes
      end
    end
  end
end
