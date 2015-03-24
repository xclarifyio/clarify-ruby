
module ClarifyTests
  # Used for catching and re-throwing exceptions used in tests. Guarantees that
  # an exception won't be swalloawed when integrated with After commands.
  class Exceptions
    attr_writer :caught

    def initialize
      @caught = nil
    end

    def caught
      exception = @caught
      @caught = nil

      exception
    end

    def raise_pending!
      fail @caught if exception?
    end

    def exception?
      !@caught.nil?
    end
  end
end
