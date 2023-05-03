module StripePlatform
  module Models
    class Directory
      include Enumerable

      # Returns an instance of the API direcetory
      #
      # @param collection [Array]
      #
      # @return [StripePlatform::Models::Directory]
      def initialize(collection=[])
        @collection = Array(collection)
      end

      # Returns the directory of routes
      #
      # @param params [Hash]
      #
      # @return [StripePlatform::Models::Directory]
      def self.list(params={})
        request = StripePlatform::Requests::Directory.list(params)

        return self.new(request)
      end

      # Implement enumerable
      #
      # @return [noop]
      def each(&block)
        internal_collection.each(&block)
      end

      # Returns the directeory to an instance of restless router
      #
      # This gives us the ability to view the routes
      #
      # @return [RestlessRouter::Routes]
      def to_restless_router
        routes = RestlessRouter::Routes.new

        self.each do |record|
          routes.add_route(record)
        end

        routes
      end

      private
      def internal_collection
        @collection.map { |record| StripePlatform::Models::DirectoryEntry.new(record) }
      end
    end
  end
end
