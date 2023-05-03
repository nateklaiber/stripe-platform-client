require 'delegate'
require 'logger'

module StripePlatform
  class Logger < SimpleDelegator
    DEFAULT_PROGNAME = "STRIPE_PLATFORM_RUBY_CLIENT"

    # Returns an instance of the logger
    #
    # @param name [String]
    # @param shift_age [Integer]
    # @param shift_size [Integer]
    #
    # @return [StripePlatform::Logger]
    def initialize(name, shift_age=7, shift_size=1048576)
      @_logger = ::Logger.new(name, shift_age, shift_size)
    end

    # Delegate the warn
    #
    # @param progname [String]]
    #
    # @return [Boolean]
    def warn(progname = nil, &block)
      @_logger.warn((progname || DEFAULT_PROGNAME), &block)
    end

    # Delegate the debug
    #
    # @param progname [String]]
    #
    # @return [Boolean]
    def debug(progname = nil, &block)
      @_logger.debug((progname || DEFAULT_PROGNAME), &block)
    end

    # Delegate the fatal
    #
    # @param progname [String]]
    #
    # @return [Boolean]
    def fatal(progname = nil, &block)
      @_logger.fatal((progname || DEFAULT_PROGNAME), &block)
    end

    # Delegate the error
    #
    # @param progname [String]]
    #
    # @return [Boolean]
    def error(progname = nil, &block)
      @_logger.error((progname || DEFAULT_PROGNAME), &block)
    end

    # Delegate the info
    #
    # @param progname [String]]
    #
    # @return [Boolean]
    def info(progname = nil, &block)
      @_logger.info((progname || DEFAULT_PROGNAME), &block)
    end

    # Implement simple delegator
    #
    # @return [noop]
    def __getobj__
      @_logger
    end
  end
end
