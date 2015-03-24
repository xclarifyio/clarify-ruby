
require 'json'

module Clarify
  module Responses
    # A Collection represents a list of results from the API, primarily used in
    # the Bundle list and the Search results (a SearchCollection.)
    #
    # A collection can be paged through using next / prev / first / last link
    # relations.
    class Collection < Clarify::Response
      include Enumerable

      def each
        items.each { |i| yield i['href'] }
      end

      def items
        body['_links']['items']
      end

      def more?
        !self.next.nil?
      end

      def next
        relation('next')
      end
    end
  end
end
