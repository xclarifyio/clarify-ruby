require_relative 'request'

module Clarify
  class Metadata < Request

    def find(bundle_id)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.get("/#{version_name}/bundles/#{bundle_id}/metadata", headers: headers)
      build_response(response)
    end

    def delete(bundle_id)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.delete("/#{version_name}/bundles/#{bundle_id}/metadata", headers: headers)
      build_response(response)
    end

    def update(bundle_id, data="")
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?      
      response = self.class.put("/#{version_name}/bundles/#{bundle_id}/metadata",
                                body: {data: data} , headers: headers)
      build_response(response)
    end

  end
end
