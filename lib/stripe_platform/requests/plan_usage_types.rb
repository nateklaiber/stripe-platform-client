module StripePlatform
  module Requests
    class PlanUsageTypes

      # Returns a list of the plan usage types
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/plan_usage_types.json').read)
      end
    end
  end
end
