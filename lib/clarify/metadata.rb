require_relative 'request'

module Clarify
  class Metadata < Request
    
    def initialize(version=1)
      super(version)
    end

    def find(bundle_id)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.get("/#{version}/bundles/#{bundle_id}/metadata", headers: headers)
      build_response(response)
    end

    def delete(bundle_id)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.delete("/#{version}/bundles/#{bundle_id}/metadata", headers: headers)
      build_response(response)
    end

    def update(bundle_id, data="")
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?      
      response = self.class.put("/#{version}/bundles/#{bundle_id}/metadata",
                                body: {data: data} , headers: headers)
      build_response(response)
    end

  end
end
