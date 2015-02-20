require_relative 'request'

module Clarify
  class Bundle < Request

    def bundle_url
        "/v1/bundles"
    end

    def create(query={})
      response = self.class.post("#{bundle_url}",
                                 body: query,
                                 headers: self.headers)
      build_response(response)
    end

    def find(bundle_id, args={})
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.get("#{bundle_url}/#{bundle_id}", query: args, headers: headers)
      build_response(response)
    end

    def find_all(args={})
      response = self.class.get("#{bundle_url}", headers: headers)
      build_response(response)
    end

    def delete(bundle_id)
      response = self.class.delete("#{bundle_url}/#{bundle_id}", headers: headers)
      build_response(response)
    end

    def update(bundle_id, query={})
      response = self.class.put("#{bundle_url}/#{bundle_id}",
                                body: query, headers:   headers)
      build_response(response)
    end

  end
end
