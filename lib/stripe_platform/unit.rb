require 'ruby_units/namespaced'

module StripePlatform
  class Unit < SimpleDelegator

    # Returns an instance of the Unit library
    #
    # @param options
    #
    # @raise [StripePlatform::Errors::MissingUnitDefinitionError]
    #
    # @return [StripePlatform::Unit]
    def initialize(*options)
      begin
        @_record = RubyUnits::Unit.new(options)
      rescue
        raise StripePlatform::Errors::MissingUnitDefinitionError.new("Could not find unit definition for %s" % [*options])
      end
    end

    # Implement simple delegator
    #
    # @return [noop]
    def __getobj__
      @_record
    end
  end
end
