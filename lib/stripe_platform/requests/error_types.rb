module StripePlatform
  module Requests
    class ErrorTypes

      # Returns a list of the error types
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/error_types.json').read)
      end
    end
  end
end
