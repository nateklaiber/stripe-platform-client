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

      def type_value
        @attributes['type']
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

      def default_price_attributes
        if self.default_price_value.is_a?(Hash)
          Hash(self.default_price_value)
        else
          {}
        end
      end

      def default_price_attributes?
        !self.default_price_attributes.empty?
      end

      def default_price
        @default_price ||= if self.default_price_attributes?
          StripePlatform::Models::Price.new(self.default_price_attributes)
        else
          StripePlatform::Models::Prices.retrieve(self.default_price_id)
        end
      end

      def default_price?
        !self.default_price.nil?
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

      def statement_descriptor
        @attributes['statement_descriptor']
      end

      def unit_label
        @attributes['unit_label']
      end

      def package_dimensions_attributes
        @attributes['package_dimensions']
      end

      def package_dimensions
        @package_dimensions ||= StripePlatform::Models::PackageDimension.new(self.package_dimensions_attributes)
      end

      def is_shippable
        @attributes['shippable']
      end
      alias is_shippable? is_shippable
      alias shippable? is_shippable

      def url_value
        @attributes['url']
      end

      def url
        begin
          @url ||= StripePlatform::ResourceUri.new(self.url_value)
        rescue
          nil
        end
      end

      def url?
        !self.url.nil?
      end

      def tax_code_value
        @attributes['tax_code']
      end

      # Returns the updated unix timestamp
      #
      # @return [Integer]
      def updated_unix_timestamp
        @attributes['updated']
      end

      # Returns the updated at time
      #
      # @return [Time,NilClass]
      def updated_at
        begin
          Time.at(self.updated_unix_timestamp).utc
        rescue
          nil
        end
      end

      # Returns true if there is a updated at
      #
      # @return [Boolean]
      def updated_at?
        !self.updated_at.nil?
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
