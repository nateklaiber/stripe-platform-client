module StripePlatform
  module Models
    class TransformUsage

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def divide_by
        begin
        Integer(@attattributes['divide_by'])
        rescue
          nil
        end
      end

      def divide_by?
        !self.divide_by.nil?
      end

      def round_value
        @attributes['round']
      end
      alias round_id round_value

      def round
        @round ||= StripePlatform::Models::RoundDirections.retrieve(self.round_value)
      end
      alias round_direction round

      def round?
        !self.round.nil?
      end

      def any?
        !@attributes.empty?
      end

      def to_attributes
        @attributes
      end
    end
  end
end
