module StripePlatform
  module Models
    class InvoiceSettings
      def initialize(attributes={})
        @attributes = Hash(attributes)
      end

      def custom_fields_attributes
        Array(@attributes.fetch('custom_fields', []))
      end

      def custom_fields
        @custom_fields ||= StripePlatform::Models::CustomFields.new(self.custom_fields_attributes)
      end

      def custom_fields?
        self.custom_fields.any?
      end

      def default_payment_method_value
        @attributes['default_payment_method']
      end

      def default_payment_method_attributes
        if self.default_payment_method_value.is_a?(Hash)
          Hash(self.default_payment_method_attributes)
        else
          {}
        end
      end

      def default_payment_method_attributes?
        !self.default_payment_method_attributes.empty?
      end

      def default_payment_method_id
        if self.default_payment_method_value.is_a?(String)
          self.default_payment_method_value
        end
      end

      def default_payment_method_id?
        !self.default_payment_method_id.nil?
      end

      def default_payment_method
        @default_payment_method ||= if self.default_payment_method_attributes?
                                      StripePlatform::Models::PaymentMethod.new(self.default_payment_method_attributes)
                                    else
                                      StripePlatform::Models::PaymentMethods.retrieve(self.default_payment_method_id)
                                    end
      end

      def default_payment_method?
        !self.default_payment_method.nil?
      end

      def footer
        @attributes['footer']
      end

      def rendering_options_attributes
        Hash(@attributes.fetch('rendering_options', {}))
      end

      def to_attributes
        @attributes
      end
    end
  end
end
