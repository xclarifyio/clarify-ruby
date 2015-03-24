
module Clarify
  module Responses
    # The Tracks class represents a collection of tracks within a bundle. A
    # bundle may have zero or more tracks. Iterating over a Tracks object will
    # yield each track in the tracks resource.
    class Tracks < Clarify::Response
      include Enumerable

      def each
        body['tracks'].each { |i| yield i }
      end
    end
  end
end
