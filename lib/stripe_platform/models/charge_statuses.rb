module StripePlatform
  module Models
    class ChargeStatuses
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list
        request = StripePlatform::Requests::ChargeStatuses.list

        return self.new(request)
      end

      def self.retrieve(id)
        records = self.list
        records.retrieve(id)
      end

      def each(&block)
        internal_collection.each(&block)
      end

      def retrieve(id)
        self.find { |record| record.id.to_s == id.to_s }
      end

      def to_attributes
        Array(self.map(&:to_attributes))
      end

      private
      def internal_collection
        @collection.map { |record| StripePlatform::Models::ChargeStatus.new(record) }
      end
    end
  end
end
