module StripePlatform
  module Models
    class CustomFields
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def to_attributes
        Array(self.map(&:to_attributes))
      end

      private
      def internal_collection
        @collection.map { |record| StripePlatform::Models::CustomField.new(record) }
      end
    end
  end
end
