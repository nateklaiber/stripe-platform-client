module StripePlatform
  module Requests
    class CollectionMethods

      # Returns a list of the collection methods
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/collection_methods.json').read)
      end
    end
  end
end
