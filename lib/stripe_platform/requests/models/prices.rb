module StripePlatform
  module Requests
    module Models
      class Prices
        def initialize(attributes={})
          @attributes = Hash(attributes)
        end

        def self.from_original_attributes(attributes)
          record_attributes = Hash(attributes)

          params = {
            :version           => record_attributes['version'],
            :expand            => record_attributes.fetch('expand', []),
            :is_active         => record_attributes['active'],
            :currency_code     => record_attributes['currency'],
            :product_id        => record_attributes['product'],
            :price_type_id     => record_attributes['type'],
            :created           => record_attributes.fetch('created', {}),
            :ending_before     => record_attributes['ending_before'],
            :starting_after    => record_attributes['starting_after'],
            :limit             => record_attributes['limit'],
          }

          params
        end

        def self.from_original(attributes)
          klass = self.new(self.from_original_attributes(attributes))
          klass
        end

        def version
          @attributes[:version]
        end

        def starting_after
          @attributes[:starting_after]
        end

        def ending_before
          @attributes[:ending_before]
        end

        def limit
          @attributes[:limit]
        end

        def created_attributes
          Hash(@attributes.fetch(:created, {}))
        end

        def created
          @created ||= StripePlatform::Requests::Models::TimestampQuery.new(self.created_attributes)
        end

        def expand_attributes
          Array(@attributes.fetch(:expand, []))
        end

        def expand_attributes?
          self.expand_attributes.any?
        end

        def is_active
          @attributes[:is_active]
        end

        def currency_code
          @attributes[:currency_code]
        end

        def product_id
          @attributes[:product_id]
        end

        def product
          @product ||= StripePlatform::Models::Products.retrieve(self.product_id)
        end

        def product?
          !self.product.nil?
        end

        def price_type_id
          @attributes[:price_type_id]
        end

        def is_active
          @attributes[:is_active]
        end

        def as_original_attributes
          attrs = {
            'version'        => self.version,
            'starting_after' => self.starting_after,
            'ending_before'  => self.ending_before,
            'limit'          => self.limit,
            'active'         => self.is_active,
            'type'           => self.price_type_id,
            'product'        => self.product_id,
            #'created'        => self.created.as_original_attributes,
          }

          if self.expand_attributes?
            attrs.merge!('expand' => self.expand_attributes)
          end

          attrs
        end

        def as_query_attributes
          self.as_original_attributes
        end

        def as_form_encoded_attributes
          self.as_original_attributes
        end

        def as_form_encoded
          Rack::Utils.build_nested_query(self.as_form_encoded_attributes)
        end

        def as_query_encoded
          Rack::Utils.build_nested_query(self.as_query_attributes)
        end

        def as_json(*)
          self.as_original_attributes
        end
      end
    end
  end
end
