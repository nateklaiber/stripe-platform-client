module StripePlatform
  class ResourceIo
    CHUNK_SIZE = 5242880
    UNIT_BYTES = 'bytes'.freeze

    # Returns an instance of the wrapped IO object
    #
    # @param io [IO]
    #
    # @return [StripePlatform::ResourceIo]
    def initialize(io)
      @io = io
    end

    # Returns the IO object
    #
    # @return [IO]
    def io
      @io
    end

    # Reads the IO object
    #
    # @return [String]
    def read
      self.io.read.extend(StripePlatform::Extensions::String)
    end
    alias body read

    # Returns the file size in bytes
    #
    # @return [Integer]
    def file_size_bytes
      self.io.size
    end

    # Returns the file size unit
    #
    # @return [StripePlatform::Unit]
    def file_size_unit
      begin
        StripePlatform::Unit.new(self.file_size_bytes, UNIT_BYTES)
      rescue
        nil
      end
    end

    # Returns the checkum of the IO
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
