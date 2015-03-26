
module Clarify
  # A Configuration class represents the server to communicate with, and the
  # credentials to consume. You can use multiple Configuration objects with
  # multiple RestClient objects to support multiple accounts in the same
  # application.
  class Configuration
    attr_reader :api_key
    attr_reader :server

    def initialize(conf = {})
      @api_key = conf.fetch(:api_key)
      @server = conf.fetch(:server, 'https://api.clarify.io')
    end

    def api_key?
      return false unless api_key
      return false if api_key.empty?
      true
    end

    def ssl?
      uri.scheme == 'https'
    end

    def host
      uri.host
    end

    def port
      uri.port
    end

    def uri
      URI(server)
    end
  end
end
