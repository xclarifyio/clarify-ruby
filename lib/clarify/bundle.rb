require_relative 'request'

module Clarify
  class Bundle < Request

    def create(query={})
      response = self.class.post("/#{version_name}/bundles",
                                 body: query,
                                 headers: self.headers)
      build_response(response)
    end

    def find(bundle_id, args={})
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.get("/#{version_name}/bundles/#{bundle_id}", query: args, headers: headers)
      build_response(response)
    end

    def find_all(args={})
      response = self.class.get("/#{version_name}/bundles", headers: headers)
      build_response(response)
    end

    def delete(bundle_id)
      response = self.class.delete("/#{version_name}/bundles/#{bundle_id}", headers: headers)
      build_response(response)
    end

    def update(bundle_id, query={})
      response = self.class.put("/#{version_name}/bundles/#{bundle_id}",
                                body: query, headers:   headers)
      build_response(response)
    end

  end
end
