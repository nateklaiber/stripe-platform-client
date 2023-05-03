require File.expand_path('../utilities/status_code_mapper', __FILE__)
require 'faraday_middleware'
require 'delegate'

module StripePlatform
  class Response < SimpleDelegator
    STATUS_MAP = {
      :failure      => (400...500),
      :redirect     => (300...400),
      :success      => (200...300),
      :server_error => (500...600)
    }

    # Returns a general http response
    #
    # @param response [Faraday::Response] HTTP response
    #
    # @return [StripePlatform::Response]
    def initialize(response)
      @_response = response
    end

    # Returns true if the method is allowed
    #
    # @return [Boolean]
    def allowed?(method)
      self.allowed_methods.include?(method.upcase)
    end

    # Helper to handle the status or status ranges
    #
    # @param statuses [Array]
    #
    # @return [StripePlatform::Response,NilClass]
    def on(*statuses, &block)
      status_code_mapper = StripePlatform::Utilities::StatusCodeMapper.new(statuses)

      return unless status_code_mapper.includes?(@_response.status)

      if block_given?
        yield(self)
      else
        self
      end
    end

    # Returns true if this is a redirect
    #
    # @return [Boolean]
    def redirect?
      STATUS_MAP[:redirect].include?(self.status)
    end

    # Returns true if this is a fialure
    #
    # @return [Boolean]
    def failure?
      STATUS_MAP[:failure].include?(self.status)
    end

    # Returns true if this is a server error
    #
    # @return [Boolean]
    def server_error?
      STATUS_MAP[:server_error].include?(self.status)
    end

    # Implement simple delegator
    #
    # @return [noop]
    def __getobj__
      @_response
    end

    # Return the allow header value
    #
    # @return [String]
    def allow_header
      self.headers.fetch('allow', '')
    end

    # Returns true if this is a JSON body
    #
    # @return [Boolean]
    def json?
      self.body.is_a?(Hash)
    end

    # Returns the links header
    #
    # @return [String]
    def links_header
      self.headers.fetch('link', '')
    end

    # Returns true if there is a link header
    #
    # @return [Boolean]
    def links_header?
      self.headers.has_key?('link')
    end

    # Returns the normalized links
    #
    # @return [Array]
    def links_attributes
      if self.json?
        self.body['links']
      else
        []
      end
    end

    # Returns true if there are any links attributes
    #
    # @return [Boolean]
    def links_attributes?
      self.links_attributes.any?
    end

    # Returns the set of allowed methods
    #
    # @return [Array]
    def allowed_methods
      self.allow_header.split(',').map(&:strip).map(&:upcase)
    end
  end
end
