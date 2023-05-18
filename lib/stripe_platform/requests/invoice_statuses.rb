module StripePlatform
  module Requests
    class InvoiceStatuses

      # Returns a list of the invoice statuses
      #
      # @param params [Hash]
      #
      # @return [MultiJson]
      def self.list(params={})
        MultiJson.load(StripePlatform::Client.root.join('data/invoice_statuses.json').read)
      end
    end
  end
end
