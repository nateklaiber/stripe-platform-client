module StripePlatform
  module Extensions
    module Hash

      # Returns the cache key
      #
      # @return [String]
      def cache_key
        self.map { |k,v| [k,v].join(':') }.join('::')
      end
    end
  end
end
