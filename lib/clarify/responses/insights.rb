
require 'json'

module Clarify
  module Responses
    # An Insights class represents a list of links to insights which have been
    # processed by the API. This class is used to locate insight documents.
    #
    # You can enumerate over the insight URLs and get names / urls of insights.
    class Insights < Clarify::Response
      include Enumerable

      def each
        items.each { |name, insight| yield name, insight['href'] }
      end

      def items
        body['_links'].select { |name, _| name[0..7] == 'insight:' }
      end
    end
  end
end
