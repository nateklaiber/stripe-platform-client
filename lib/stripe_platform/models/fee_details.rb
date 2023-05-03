module StripePlatform
  module Models
    class FeeDetails
      include Enumerable

      # Returns an instance of the fee details
      #
      # @param collection [Array]
      #
      # @Return [StripePlatform::Models::FeeDetails]
      def initialize(collection=[])
        @collection = Array(collection)
      end

      # Implement enumerable
      def each(&block)
        internal_collection.each(&block)
      end

      # Returns the original attributes
      #
      # @return [Array<Hash>]
      def to_attributes
        Array(self.map(&:to_attributes))
      end

      private
      def internal_collection
        @collection.map { |record| StripePlatform::Models::FeeDetail.new(record) }
      end
    end
  end
end
