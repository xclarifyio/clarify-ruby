require_relative 'request'

module Clarify
  class Track < Request

    def all(bundle_id)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.get("/#{version_name}/bundles/#{bundle_id}/tracks", headers: headers)
      build_response(response)
    end

    def add(bundle_id, media_url) 
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      raise ArgumentError, "Missing media_url" if media_url.nil?
      response = self.class.post("/#{version_name}/bundles/#{bundle_id}/tracks", body: {media_url: media_url}, headers: headers)
      build_response(response)  
    end

    def delete(bundle_id, track="")
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.delete("/#{version_name}/bundles/#{bundle_id}/tracks", query: {track: track}, headers: headers)
      build_response(response)  
    end

    def delete_by_id(bundle_id, track_id)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      raise ArgumentError, "Missing track id" if track_id.nil?
      response = self.class.delete("/#{version_name}/bundles/#{bundle_id}/tracks/#{track_id}", headers: headers)
      build_response(response)  
    end

    def find(bundle_id, track_id)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      raise ArgumentError, "Missing track id" if track_id.nil?
      response = self.class.get("/#{version_name  }/bundles/#{bundle_id}/tracks/#{track_id}", headers: headers)
      build_response(response)    
    end

  end
end
