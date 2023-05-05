module StripePlatform
  module Requests
    class TokenTypes

      # Returns a list of the token types
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/token_types.json').read)
      end
    end
  end
end
