module StripePlatform
  module Models
    class Tokens
      include Enumerable

      def initialize(collection=[])
        @collection = Array(collection)
      end

      def self.retrieve(id, &block)
        request = StripePlatform::Requests::Tokens.retrieve(id, &block)

        request.on(:success) do |resp|
          response_body = resp.body

          return StripePlatform::Models::Token.new(response_body)
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
        @collection.map { |record| StripePlatform::Models::Token.new(record) }
      end
    end
  end
end
