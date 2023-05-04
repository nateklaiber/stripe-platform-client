module StripePlatform
  module Requests
    module Models
      class Card
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :exp_month => record_attributes['exp_month'],
            :exp_year  => record_attributes['exp_year'],
            :number    => record_attributes['number'],
            :cvc       => record_attributes['cvc'],
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def brand_id
          @attributes[:brand_id]
        end

        def brand
          StripePlatform::Models::CardBrands.retrieve(self.brand_id)
        end

        def brand?
          !self.brand.nil?
        end

        def country
          @attributes[:country]
        end

        def exp_month
          @attributes[:exp_month]
        end

        def exp_year
          @attributes[:exp_year]
        end

        def last_4
          @attributes[:last_4]
        end

        def number
          @attributes[:number]
        end

        def funding_type_id
          @attributes[:funding_type_id]
        end

        def funding_type
          StripePlatform::Models::CardFundingTypes.retrieve(self.funding_type_id)
        end

        def funding_type?
          !self.funding_type.nil?
        end

        def cvc
          @attributes[:cvc]
        end

        def as_original_attributes
          attrs = {
            'exp_month' => self.exp_month,
            'exp_year'  => self.exp_year,
            'number'    => self.number,
            'cvc'       => self.cvc,
          }

          attrs
        end

        def as_form_encoded_attributes
          self.as_original_attributes
        end

        def as_form_encoded
          Rack::Utils.build_nested_query(self.as_original_attributes)
        end

        def as_json(*)
          self.as_original_attributes
        end
      end
    end
  end
end
