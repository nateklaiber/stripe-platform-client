require File.expand_path('../configurations', __FILE__)

module StripePlatform
  class Configuration
    # Connection
    attr_accessor :api_host
    attr_accessor :access_token
    attr_accessor :connection_options

    # Request
    attr_accessor :user_agent
    attr_accessor :media_type
    attr_accessor :content_type
    attr_accessor :version
    attr_accessor :active_version

    # Logging
    attr_accessor :request_logger
    attr_accessor :cache_logger
    attr_accessor :logger

    # Returns the set of allows configuration
    # options
    #
    # @return [Array<Symbol>] Configuration keys
    def self.keys
      @keys ||= [
        :api_host,
        :access_token,
        :connection_options,
        :user_agent,
        :media_type,
        :content_type,
        :version,
        :active_version,
        :request_logger,
        :cache_logger,
        :logger
      ]
    end

    # Create a new instance of the Configuration object.
    #
    # This will be initialized with user-supplied values
    # or vall back to the Default configuration object
    #
    # @example
    #   configuration = StripePlatform::Configuration.new(access_token: 'abcd')
    #
    #   configuration.access_token
    #   # => "abcd"
    #
    # @param attributes [Hash] Hash of configuration keys and values
    #
    # @return [StripePlatform::Configuration] Instance of the object
    #
    def initialize(attributes={})
      self.class.keys.each do |key|
        instance_variable_set(:"@#{key}", (attributes[key] || StripePlatform::Configurations::Default.options[key]))
      end
    end

    # The final set of connection options..
    #
    # @return [Hash] Connection options
    def connection_options
      {
        :headers => {
          :accept       => self.media_type,
          :user_agent   => self.user_agent,
          :content_type => self.content_type
        }
      }
    end

    # Allows you to configure the object after it's
    # been initialized.
    #
    # @return [StripePlatform::Configuration] The configuration instance
    def configure(&block)
      yield(self)
    end

    # This allows you to reset your configuration back to the
    # default state
    #
    # @return [StripePlatform::Configuration] The configuration with Defaults applied
    def reset!
      self.class.keys.each do |key|
        instance_variable_set(:"@#{key}", StripePlatform::Configurations::Default.options[key])
      end
    end
    alias :setup :reset!
  end
end

