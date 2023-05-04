module StripePlatform
  module Models
    class Event
      extend Forwardable

      def_delegator :event_data, :object, :source

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

      def api_version
        @attributes['api_version']
      end

      def type_value
        @attributes['type']
      end
      alias type_id type_value

      def type
        @type ||= StripePlatform::Models::EventTypes.retrieve(self.type_value)
      end

      def type?
        !self.type.nil?
      end

      def data_attributes
        Hash(@attributes.fetch('data', {}))
      end

      def event_data_attributes
        self.data_attributes.merge!('type' => self.type_value)
      end

      def event_data
        @event_data ||= StripePlatform::Models::EventData.new(self.event_data_attributes)
      end

      def is_livemode
        @attributes['livemode']
      end
      alias is_livemode? is_livemode
      alias livemode? is_livemode

      def pending_webhooks_count
        @attributes['pending_webhooks']
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

      # Returns the original attributes
      #
      # @return [Hash]
      def to_attributes
        @attributes
      end
    end
  end
end
