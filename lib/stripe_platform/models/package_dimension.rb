module StripePlatform
  module Models
    class PackageDimension
      HEIGHT_UNIT = 'inch'.freeze
      WEIGHT_UNIT = 'oz'.freeze
      LENGTH_UNIT = 'inch'.freeze
      WIDTH_UNIT  = 'inch'.freeze

      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def height_value
        begin
          BigDecimal(@attributes['height'].to_s)
        rescue
          nil
        end
      end

      def height_unit_value
        HEIGHT_UNIT
      end

      def height_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.height_value.to_f, self.height_unit_value]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      def length_value
        begin
          BigDecimal(@attributes['length'].to_s)
        rescue
          nil
        end
      end

      def length_unit_value
        LENGTH_UNIT
      end

      def length_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.length_value.to_f, self.length_unit_value]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      def weight_value
        begin
          BigDecimal(@attributes['weight'].to_s)
        rescue
          nil
        end
      end

      def weight_unit_value
        WEIGHT_UNIT
      end

      def weight_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.weight_value.to_f, self.weight_unit_value]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      def width_value
        begin
          BigDecimal(@attributes['weight'].to_s)
        rescue
          nil
        end
      end

      def width_unit_value
        WIDTH_UNIT
      end

      def width_unit
        begin
          StripePlatform::Unit.new(("%s %s" % [self.width_value.to_f, self.width_unit_value]))
        rescue => e
          StripePlatform::Client.logger.info do
            e.message
          end

          nil
        end
      end

      def display_name
        [self.length_unit, self.width_unit, self.height_unit].join(' x ')
      end

      def to_attributes
        @attributes
      end
    end
  end
end
