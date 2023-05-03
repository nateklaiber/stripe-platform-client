module StripePlatform
  module Requests
    class Directory

      # Returns a list of the directory routes
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/routes.json').read)
      end
    end
  end
end
