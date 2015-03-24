
module Clarify
  module Responses
    # The Tracks class represents a collection of tracks within a bundle. A
    # bundle may have zero or more tracks. Iterating over a Tracks object will
    # yield each track in the tracks resource.
    class NoBody < Clarify::Response
      def initialize(response)
        super response, nil
      end
    end
  end
end
