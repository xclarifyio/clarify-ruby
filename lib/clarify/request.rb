require 'httparty'
require 'json'

module Clarify

  Response = Struct.new(:status, :data)

  class Request
    include HTTParty
    base_uri "https://api.clarify.io/"

    #uncomment below for httparty debugging
    #debug_output

    attr_accessor :version, :auth_key

    def initialize(version = 1)
      @version = "v#{version}"
      @auth_key = ENV['CLARIFY_API_KEY']
    end

    def headers
      {"Authorization" => "Bearer #{@auth_key}"}
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

