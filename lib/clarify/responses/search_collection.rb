
module Clarify
  module Responses
    # A SearchCollection represents a list of search results from the API.
    #
    # A collection can be paged through using next / prev / first / last link
    # relations.
    class SearchCollection < Clarify::Responses::Collection
      def each
        items.each { |result, ref| yield result, ref['href'] }
      end

      def items
        body['item_results'].zip(body['_links']['items'])
      end
    end
  end
end
