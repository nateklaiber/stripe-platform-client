module StripePlatform
  module Models
    class SubscriptionItems
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.list(params={}, &block)
        request = StripePlatform::Requests::SubscriptionItems.list(params, &block)

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

      def self.create(record_attributes, params={}, &block)
        request = StripePlatform::Requests::SubscriptionItems.create(record_attributes, params, &block)

        request.on(:success) do |resp|
          response_body = resp.body

          return StripePlatform::Models::SubscriptionItem.new(response_body)
        end

        request.on(:failure) do |resp|
          response_body = resp.body
          error         = StripePlatform::Models::Error.new(response_body)

          StripePlatform::Client.logger.info do
            error.message
          end

          error.raise_exception!
        end
      end

      def self.retrieve(id, params={}, &block)
        request = StripePlatform::Requests::SubscriptionItems.retrieve(id, params, &block)

        request.on(:success) do |resp|
          response_body = resp.body

          return StripePlatform::Models::SubscriptionItem.new(response_body)
        end

        request.on(:failure) do |resp|
          return nil
        end
      end

      def self.update(id, record_attributes={}, params={}, &block)
        request = StripePlatform::Requests::SubscriptionItems.update(id, record_attributes, params, &block)

        request.on(:success) do |resp|
          response_body = resp.body

          return StripePlatform::Models::SubscriptionItem.new(response_body)
        end

        request.on(:failure) do |resp|
          return nil
        end
      end

      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| StripePlatform::Models::SubscriptionItem.new(record) }
      end
    end
  end
end
