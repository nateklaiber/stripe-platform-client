module StripePlatform
  module Requests
    class ChargeStatuses

      # Returns a list of the charge statuses
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/charge_statuses.json').read)
      end
    end
  end
end
