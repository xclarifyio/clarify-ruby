
module Clarify
  # Iterate over a paginated collection
  class CollectionIterator
    include Enumerable

    def initialize(restclient, collection)
      @restclient = restclient
      @collection = collection
    end

    def each
      collections.each { |collection| collection.each { |*i| yield(*i) } }
    end

    def collections
      Enumerator.new do |y|
        current = @collection
        loop do
          y << current
          break unless current.more?
          current = @restclient.get(current.next)
        end
      end
    end
  end
end
