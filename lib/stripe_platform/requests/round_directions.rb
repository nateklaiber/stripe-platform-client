module StripePlatform
  module Requests
    class RoundDirections

      # Returns a list of the round directions
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/round_directions.json').read)
      end
    end
  end
end
