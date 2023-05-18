module StripePlatform
  module Models
    class TimePeriod

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def start_unix_timestamp
        @attributes['start']
      end

      def start_at
        begin
          Time.at(self.start_unix_timestamp)
        rescue
          nil
        end
      end

      def start_at?
        !self.start_at.nil?
      end

      def end_unix_timestamp
        @attributes['end']
      end

      def end_at
        begin
          Time.at(self.end_unix_timestamp)
        rescue
          nil
        end
      end

      def end_at?
        !self.end_at.nil?
      end

      def range
        @range ||= Range.new(self.start_at, self.end_at)
      end

      def to_attributes
        @attributes
      end
    end
  end
end

