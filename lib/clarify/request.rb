require 'httparty'
require 'json'

module Clarify
  class Request
    include HTTParty
    base_uri "https://api.clarify.io/"
    
    Response = Struct.new(:status, :data)
    
    def initialize(version = 1)
      @version = "v#{version}"
      @auth_key = ENV['CLARIFY_API_KEY']
    end

    def create_bundle(query = {})
      response = self.class.post("/#{@version}/bundles",
                      query: query,
                      headers: headers)
      #TODO: send response when not successful
      build_response(response)
    end

    def fetch_bundle(bundle_id=nil, embed="")
      raise ArgumentError, "Missing bundle id" if bundle_id.nil?
      response = self.class.get("/#{@version}/bundles/#{bundle_id}?embed=#{embed}", headers: headers)
      build_response(response)
    end

    private

    def headers
      {"Authorization" => "Bearer #{@auth_key}"}
    end

    def build_response(response)
      Response.new(response.code,
                   JSON.parse(response.parsed_response, symbolize_names: true))
    end
  end
end

