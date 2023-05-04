module StripePlatform
  module Requests
    class EventTypes

      # Returns a list of the event types
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/event_types.json').read)
      end
    end
  end
end
