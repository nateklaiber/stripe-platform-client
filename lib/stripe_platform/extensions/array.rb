module StripePlatform
  module Extensions
    module Array

      # Returns the cache key for the array
      #
      # @return [String]
      def cache_key
        Array(self).map(&:to_s).join('::')
      end

      # Returns the set of distinct elements
      #
      # @return [Array]
      def distinct
        Array(self).compact.map(&:strip).uniq.reject { |r| r.empty? }
      end
    end
  end
end
