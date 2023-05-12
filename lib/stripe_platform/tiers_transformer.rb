module StripePlatform
  class TiersTransformer
    def initialize(collection=[])
      @collection = Array(collection)
    end

    def self.transformed(collection)
      klass = self.new(collection)
      klass.transformed_attributes
    end

    def tiers_attributes
      @collection
    end

    def transformed_attributes
      self.resolved_tiers_attributes
    end

    def sorted_tiers_attributes
      self.tiers_attributes.sort do |a,b|
        [a['up_to'] ? 0 : 1, a['up_to']] <=> [b['up_to'] ? 0 : 1, b['up_to']]
      end
    end

    def resolved_tiers_attributes
      resolved_records = []

      range_memo = {}
      range_memo[:start] = 0
      range_memo[:end]   = nil

      self.sorted_tiers_attributes.each_with_index.inject(resolved_records) do |col, (tier_attributes,idx)|
        record_attributes = tier_attributes
        record_attributes.merge!('index' => (idx + 1))

        if !tier_attributes['up_to'].nil?
          if idx == 0
            record_attributes.merge!('up_from' => 1)
            record_attributes.merge!('start_at' => 1)
            record_attributes.merge!('end_at' => tier_attributes['up_to'])

            range_memo[:start] = 1
            range_memo[:end] = tier_attributes['up_to']
          else
            up_from = (range_memo[:end] + 1)

            record_attributes.merge!('up_from' => up_from)
            record_attributes.merge!('start_at' => up_from)
            record_attributes.merge!('end_at' => tier_attributes['up_to'])

            range_memo[:start] = up_from
            range_memo[:end] = tier_attributes['up_to']
          end
        else
          up_from = (range_memo[:end] + 1)

          record_attributes.merge!('up_from' => up_from)
          record_attributes.merge!('start_at' => up_from)
          record_attributes.merge!('end_at' => tier_attributes['up_to'])

          range_memo[:start] = up_from
          range_memo[:end] = tier_attributes['up_to']
        end

        col.push(record_attributes)

        col
      end

      resolved_records
    end
  end
end
