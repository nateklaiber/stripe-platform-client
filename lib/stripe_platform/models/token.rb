module StripePlatform
  module Models
    class Token

      # Returns an instance of the event
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::BalanceTransaction]
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def id
        @attributes['id']
      end

      def object
        @attributes['object']
      end

      def client_ip
        @attributes['client_ip']
      end

      def type_value
        @attributes['type']
      end
      alias type_id type_value

      def type
        @type ||= StripePlatform::Models::TokenTypes.retrieve(self.type_value)
      end

      def type?
        !self.type.nil?
      end

      def data_attributes
        case(self.type.id)
        when('card')
          Hash(@attributes.fetch('card', {}))
        end
      end

      def source
        self.type.object_for(data_attributes)
      end

      def is_livemode
        @attributes['livemode']
      end
      alias is_livemode? is_livemode
      alias livemode? is_livemode

      def is_used
        @attributes['used']
      end
      alias is_used? is_used
      alias used? is_used

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

      # Returns the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
