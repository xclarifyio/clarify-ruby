
module Clarify
  # A simple entrypoint to the API. Exposes access to search and CRUD
  # operations on Bundles.
  class BundleRepository
    def initialize(client)
      @client = client
    end

    def fetch
      @client.get('/v1/bundles')
    end

    def search(query_string)
      @client.get('/v1/search', query: query_string)
    end

    def create!(about)
      @client.post('/v1/bundles', about)
    end

    def delete!(bundle)
      @client.delete(bundle.relation!('self'))
    end
  end
end
