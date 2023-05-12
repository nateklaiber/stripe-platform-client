module StripePlatform
  module Models
    class Product

      # Returns an instance of the charge
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::Refund]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def metadata_attributes
        Hash(@attributes.fetch('metadata', {}))
      end

      def metadata
        @metadata ||= StripePlatform::Models::Metadata.new(self.metadata_attributes)
      end

      def default_price_value
        @attributes['default_price']
      end

      def default_price_id
        if self.default_price_value.is_a?(String)
          self.default_price_value
        end
      end

      def default_price_id?
        !self.default_price_id.nil?
      end

      def default_price
        # @todo
      end

      def description
        @attributes['description']
      end

      def images_attributes
        Array(@attributes.fetch('images', []))
      end

      def name
        @attributes['name']
      end

      def package_dimensions
        @attributes['package_dimensions']
      end


      # Returns the created unix timestamp
      #
      # @return [Integer]
      def created_unix_timestamp
        @attributes['created']
      end

      # Returns the created at time
      #
      # @return [Time,NilClass]
      def created_at
        begin
          Time.at(self.created_unix_timestamp).utc
        rescue
          nil
        end
      end

      # Returns true if there is a created at
      #
      # @return [Boolean]
      def created_at?
        !self.created_at.nil?
      end

      def is_active
        @attributes['active']
      end
      alias is_active? is_active
      alias active? is_active

      def is_livemode
        @attributes['livemode']
      end
      alias is_livemode? is_livemode
      alias livemode? is_livemode

      # Returns the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
