require 'digest'

module StripePlatform
  module Extensions
    module String

      # Returns the cache key for the string
      #
      # @return [String]
      def cache_key
        Digest::SHA256.hexdigest(self)
      end

      # Returns the string as base64 encoded
      #
      # @return [String]
      def base64_encoded
        Base64.encode64(self)
      end
    end
  end
end
