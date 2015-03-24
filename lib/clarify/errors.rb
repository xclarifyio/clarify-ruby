
module Clarify
  class StandardError < Exception
  end

  # This Response error is to be raised when a particular Response has a status
  # code of 401
  class UnauthenticatedError < Clarify::StandardError
    def initialize(response)
      @response = response

      super 'Response had code 401'
    end
  end

  # Handles errors where we are unable to understand the response from the API.
  class UnrecognizedResponseError < Clarify::StandardError
    def initialize(type)
      super "Unrecognized response class #{type}"
    end
  end
end
