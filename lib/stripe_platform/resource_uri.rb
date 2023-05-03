require 'mime/types'
require 'digest'
require 'open-uri'

module StripePlatform
  class ResourceUri
    CHUNK_SIZE = 5242880
    UNIT_BYTES = 'bytes'.freeze

    # Returns an instance of the decorated URI object
    #
    # @param uri_value [String]
    #
    # @raise [StripePlatform::InvalidResourceUriError]
    #
    # @return [StripePlatform::ResourceUri]
    def initialize(uri_value, &block)
      @uri_value = uri_value

      raise StripePlatform::Errors::InvalidResourceUriError.new unless [URI::FTP, URI::HTTP, URI::HTTPS].any? { |val| self.uri.kind_of?(val) }

      if block_given?
        if block.arity == 1
          yield(self)
        else
          instance_eval(self)
        end
      end
    end

    # Returns the URI value
    #
    # @return [String]
    def uri_value
      @uri_value
    end

    # Returns an instance of the URI object
    #
    # @return [URI]
    def uri
      @uri ||= URI(self.uri_value)
    end

    # Returns the contents of the URI
    #
    # @return [String]
    def contents
      URI.open(self.uri)
    end

    # Returns the IO object of the contents
    #
    # @return [StringIO]
    def io
      @io ||= self.contents
    end

    # Returns an instance of the resource IO objecet
    #
    # @return [StripePlatform::ResourceIo]
    def resource_io
      @resource_io ||= StripePlatform::ResourceIo.new(self.io)
    end

    # Returns the file name
    #
    # @return [String]
    def file_name
      File.basename(self.uri_value)
    end
    alias filename file_name

    # Read the contents of the body
    #
    # @return [String]
    def read
      self.uri.read.extend(StripePlatform::Extensions::String)
    end
    alias body read

    # Returns the file size in bytes
    #
    # @return [Integer]
    def file_size_bytes
      self.io.size
    end

    # Return the file size unit
    #
    # @return [StripePlatform::Unit,NilClass]
    def file_size_unit
      begin
        StripePlatform::Unit.new(self.file_size_bytes, UNIT_BYTES)
      rescue
        nil
      end
    end

    # Returns the base 64 encoded contents
    #
    # @return [String]
    def base64_encoded
      self.body.base64_encoded
    end

    # Returns the base 64 encoded data
    #
    # @return [String]
    def as_base64_encoded_data
      "data:%s;base64,%s" % [self.primary_mime_type, self.base64_encoded]
    end

    # Returns the mime types as discovered
    #
    # @return [Array<MIME::Type>]
    def mime_types
      MIME::Types.type_for(self.uri.to_s)
    end

    # Returns the primary mime type
    #
    # @return [MIME::Type,NilClass]
    def primary_mime_type
      self.mime_types.first
    end

    # Returns true if there is a primary mime type
    #
    # @return [Boolean]
    def primary_mime_type?
      !self.primary_mime_type.nil?
    end

    # Returns the checksum of the resource
    #
    # @return [String]
    def checksum
      Digest::MD5.new.tap do |checksum|
        while chunk = self.io.read(CHUNK_SIZE)
          checksum << chunk
        end

        self.io.rewind
      end.base64digest
    end
  end
end
