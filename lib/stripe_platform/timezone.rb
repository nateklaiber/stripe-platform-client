require 'tzinfo'

module StripePlatform
  class Timezone < SimpleDelegator

    # Returns an instance of the timezone object
    #
    # @param name [String]
    #
    # @return [StripePlatform::Timezone]
    def initialize(name)
      @name = name

      @_record = TZInfo::Timezone.get(@name)

      raise StripePlatform::Errors::MissingTimezoneError.new("Could not find timezone for %s" % [@name]) if @_record.nil?

      @_record
    end

    # Implement simple delegator
    #
    # @return [noop]
    def __getobj__
      @_record
    end
  end
end
