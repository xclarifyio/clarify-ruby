require_relative 'request'

module Clarify
  class Bundle < Request
    
    def initialize(version = 1)
      super(version)
    end

    def create(query={})
      response = self.class.post("/#{self.version}/bundles",
                                 query: query,
                                 headers: self.headers)
      build_response(response)
    end

    def find(bundle_id=nil, embed="")
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.get("/#{version}/bundles/#{bundle_id}?embed=#{embed}", headers: headers)
      build_response(response)
    end

    def find_all(args={})
      response = self.class.get("/#{version}/bundles", headers: headers)
      build_response(response)
    end

    def delete(bundle_id)
      response = self.class.delete("/#{version}/bundles/#{bundle_id}", headers: headers)
      build_response(response)
    end

    def update(bundle_id, query={})
      response = self.class.put("/#{version}/bundles/#{bundle_id}",
                                body: query, headers:   headers)
      build_response(response)
    end

  end
end
