# frozen_string_literal: true

require 'dotenv'
Dotenv.load

require 'pathname'
require 'bigdecimal'
require 'delegate'
require 'logger'
require 'date'
require 'timezone'
require 'multi_json'
require 'restless_router'
require 'rack/utils'

require_relative 'client/version'

require_relative 'unit'
require_relative 'timezone'
require_relative 'resource_io'
require_relative 'resource_uri'
require_relative 'tiers_transformer'

require_relative 'errors'
require_relative 'extensions'
require_relative 'logger'
require_relative 'configuration'
require_relative 'connection'
require_relative 'response'

require_relative 'utilities'

require_relative "requests"
require_relative "models"

module StripePlatform
  module Client
    # Class accessor methods to be utilized
    # throughout the gem itself.
    class << self
      attr_accessor :configuration
      attr_accessor :routes
    end

    # Create a default Configuration to use
    # throughout the gem
    #
    # @return [StripePlatform::Configuration] Configuration object utilizing the Default
    def self.configuration
      @configuration ||= StripePlatform::Configuration.new
    end

    # Specify configuration options. This will be applied to
    # our memoized Configuration.
    #
    # @return [StripePlatform::Configuration]
    def self.configure
      yield(self.configuration)
    end

    # Helper method to access the Connection object
    #
    # @return [StripePlatform::Connection] Faraday Response Delegator
    def self.connection
      @connection ||= StripePlatform::Connection.new(url: self.configuration.api_host) do |builder|
        builder.response(:json, content_type: /\bjson/)

        builder.response(:logger, self.configuration.request_logger)

        builder.use(:gzip)

        builder.adapter(StripePlatform::Connection.default_adapter)
      end

      # Inject Authorization
      @connection.headers['Authorization'] = ("Bearer %s" % [self.configuration.access_token])

      # Inject the active version
      @connection.headers['Stripe-Version'] = self.configuration.active_version

      # Merge default headers
      @connection.headers.merge!(self.configuration.connection_options[:headers])

      @connection
    end

    # Takes in a user access token and returns a user session
    #
    # @param access_token [String]
    #
    # @return [noop]
    def self.with_access_token(access_token, &block)
      begin
        configuration = self.configure do |c|
          c.access_token = access_token
        end

        yield(block) if block_given?
      rescue StripePlatform::Errors::InvalidAuthenticationError => e
        raise StandardError.new(e.message)
      rescue => e
        raise StandardError.new(e.inspect)
      end
    end

    # Helper method to peform a GET request
    #
    # @return [StripePlatform::Response] Faraday Response Delegator
    def self.get(url, data={}, headers={})
      request = self.connection.get(url, data, headers)

      StripePlatform::Response.new(request)
    end

    # Helper method to perform a HEAD request
    #
    # @return [StripePlatform::Response] Faraday Response Delegator
    def self.head(url, data={}, headers={})
      request = self.connection.head(url, data, headers)

      StripePlatform::Response.new(request)
    end

    # Helper method to perform a OPTIONS request
    #
    # @return [StripePlatform::Response] Faraday Response Delegator
    def self.options(url, headers={})
      request = self.connection.http_options(url, nil, headers)

      StripePlatform::Response.new(request)
    end

    # Helper method to perform a PUT request
    #
    # @return [StripePlatform::Response] Faraday Response Delegator
    def self.put(url, data={}, headers={})
      request = self.connection.put(url, data, headers)

      StripePlatform::Response.new(request)
    end

    # Helper method to perform a POST request
    #
    # @return [StripePlatform::Response] Faraday Response Delegator
    def self.post(url, data={}, headers={})
      request = self.connection.post(url, data, headers)

      StripePlatform::Response.new(request)
    end

    # Helper method to perform a DELETE request
    #
    # @return [StripePlatform::Response] Faraday Response Delegator
    def self.delete(url, data={}, headers={})
      request = self.connection.delete(url, data, headers)

      StripePlatform::Response.new(request)
    end

    # Returns the logger instance
    #
    # @return noop
    def self.logger
      self.configuration.logger
    end

    # Returns the root directory response
    #
    # @return [StripePlatform::Models::Directory]
    def self.directory
      @directory ||= StripePlatform::Models::Directory.list
    end

    # Define the API routes
    #
    # These are the endpoints that will be used to interact
    # with the API. Before you make any requests you will
    # want to add the corresponding routes here.
    #
    # @return [RestlessRouter::Routes] A collection of Routes
    def self.routes
      return @routes if @routes

      routes = self.directory
      routes = routes.to_restless_router

      @routes = routes
    end

    # Returns the link relationship for
    # a specified path.
    #
    # Custom link relationships are fully qualified
    # URIS, but in this case we only care to reference
    # the path and add the API host.
    #
    # @return [String]
    def self.rel_for(rel)
      "%s/rels/%s" % [self.api_host, rel]
    end

    # Helper method to return the API HOST
    #
    # @return [String] API URI
    def self.api_host
      self.configuration.api_host
    end

    # Returns the default version
    #
    # @return [String]
    def self.default_version
      self.configuration.version
    end

    # Returns the default query params
    #
    # @return [Hash]
    def self.default_query_params
      {
        :version       => self.default_version,
      }
    end

    # Returns the root path
    #
    # @return [Pathname]
    def self.root
      Pathname.new(File.expand_path('../../../', __FILE__))
    end
  end
end

