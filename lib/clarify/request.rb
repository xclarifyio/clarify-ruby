require 'httparty'
require 'json'

module Clarify

  Response = Struct.new(:status, :data)

  class Request
    include HTTParty
    base_uri "https://api.clarify.io/"

    #uncomment below for httparty debugging
    #debug_output

    attr_accessor :version_name, :api_key

    def initialize
      @version_name = Clarify.configuration.version_name
      @api_key = Clarify.configuration.api_key 
    end

    def headers
      {"Authorization" => "Bearer #{@api_key}",
       "User-Agent" => "clarify-gem/#{Clarify::VERSION}/#{Gem.ruby_version.version}"}
    end

    def build_response(response)
      if response.code != 204  #http code for no content
        body = JSON.parse(response.parsed_response, symbolize_names: true)
      else
        body = "" 
      end
      Response.new(response.code, body)
    end
  end
end

