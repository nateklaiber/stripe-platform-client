module StripePlatform
  module Models
    class DirectoryEntry < SimpleDelegator
      include Comparable

      # Creates an instance of the directory entry from the routes
      #
      # @param attributes [Hash]
      #
      # @return [StripePlatform::Models::DirectoryEntry]
      def initialize(attributes={})
        @attributes = Hash(attributes)

        @_record = RestlessRouter::Route.new(@attributes['rel'], @attributes['path'], templated: @attributes['templated'])
      end

      # This is a patch to support the fact that URI templates
      # do not support the 'array[]' syntax for expansion.
      #
      # @param params [Hash]
      #
      # @return [String]
      def url_for(params={})
        expand_attributes = Array(params.delete('expand'))

        if expand_attributes.any?
          parsed_url = Addressable::URI.parse(@_record.url_for(params))

          default_query_params = Hash(parsed_url.query_values)
          default_query_params.merge!('expand' => expand_attributes)

          rack_query_params = Rack::Utils.build_nested_query(default_query_params)

          parsed_url.query = rack_query_params

          return parsed_url.to_s
        else
          @_record.url_for(params)
        end
      end

      # Implement simple delegator
      #
      # @return [noop]
      def __getobj__
        @_record
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
