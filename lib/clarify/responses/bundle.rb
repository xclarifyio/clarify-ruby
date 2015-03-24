
module Clarify
  module Responses
    # Represents an individual bundle.
    class Bundle < Clarify::Response
      def name
        body['name']
      end
    end
  end
end
