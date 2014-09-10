require_relative 'request'

module Clarify
  class Track < Request

    def initialize(version=1)
      super(version) 
    end

    def all(bundle_id=nil)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.get("/#{version}/bundles/#{bundle_id}/tracks", headers: headers)
      build_response(response)
    end

    def add(bundle_id=nil, media_url=nil) 
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      raise ArgumentError, "Missing media_url" if media_url.nil?
      response = self.class.post("/#{version}/bundles/#{bundle_id}/tracks", body: {media_url: media_url}, headers: headers)
      build_response(response)  
    end

    def delete(bundle_id=nil, track=nil)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.delete("/#{version}/bundles/#{bundle_id}/tracks", query: {track: track}, headers: headers)
      build_response(response)  
    end

    def delete_by_id(bundle_id=nil, track_id=nil)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      raise ArgumentError, "Missing track id" if track_id.nil?
      response = self.class.delete("/#{version}/bundles/#{bundle_id}/tracks/#{track_id}", headers: headers)
      build_response(response)  
    end

    def find(bundle_id, track_id)
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      raise ArgumentError, "Missing track id" if track_id.nil?
      response = self.class.get("/#{version}/bundles/#{bundle_id}/tracks/#{track_id}", headers: headers)
      build_response(response)    
    end


  end
end