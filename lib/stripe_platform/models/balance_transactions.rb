module StripePlatform
  module Models
    class BalanceTransactions
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list(params={}, &block)
        request = StripePlatform::Requests::BalanceTransactions.list(params, &block)

        request.on(:success) do |resp|
          response_body    = resp.body
          general_response = StripePlatform::Models::GeneralResponse.new(response_body)

          return self.new(general_response.data)
        end

        request.on(400) do |resp|
          response_body = resp.body
          error         = StripePlatform::Models::Error.new(response_body)

          StripePlatform::Client.logger.info do
            error.message
          end

          error.raise_exception!
        end

        request.on(:failure) do |resp|
          return nil
        end
      end

      def self.retrieve(id, &block)
        request = StripePlatform::Requests::BalanceTransactions.retrieve(id, &block)

        request.on(:success) do |resp|
          response_body = resp.body

          return StripePlatform::Models::BalanceTransaction.new(response_body)
        end

        request.on(:failure) do |resp|
          return nil
        end
      end

      def for_status_attributes(status)
        self.select { |r| r.status_value == status }.map(&:to_attributes)
      end

      def for_status(status)
        self.class.new(self.for_status_attributes(status))
      end

      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| StripePlatform::Models::BalanceTransaction.new(record) }
      end
    end
  end
end
