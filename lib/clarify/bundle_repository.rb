
module Clarify
  # A simple entrypoint to the API. Exposes access to search and CRUD
  # operations on Bundles.
  class BundleRepository
    def initialize(restclient)
      @restclient = restclient
    end

    def fetch
      @restclient.get('/v1/bundles')
    end

    def search(query_string)
      @restclient.get('/v1/search', query: query_string)
    end

    def create!(about)
      @restclient.post('/v1/bundles', about)
    end

    def delete!(bundle)
      @restclient.delete(bundle.relation!('self'))
    end
  end
end
