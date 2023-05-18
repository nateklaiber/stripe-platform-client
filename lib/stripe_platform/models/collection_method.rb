module StripePlatform
  module Models
    class CollectionMethod

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def description
        @attributes['description']
      end

      def charge_automatically?
        'charge_automatically' == self.id
      end

      def send_invoice?
        'send_invoice' == self.id
      end

      def to_attributes
        @attributes
      end
    end
  end
end
