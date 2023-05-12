module StripePlatform
  module Models
    class PricingTiers
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

      def find_for_quantity(quantity)
        self.find { |record| record.matches_for_quantity?(quantity) }
      end

      private
      def internal_collection
        @collection.map { |record| StripePlatform::Models::PricingTier.new(record) }
      end
    end
  end
end
