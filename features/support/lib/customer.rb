
module ClarifyTests
  # The Customer represents a user of the API. The Customer might do things like
  # log in with particular keys, or create RestClients, Configurations, etc.
  class Customer
    attr_reader :api_key

    def initialize
    end

    def log_in_as_docs
      self.api_key = 'docs-api-key'
    end

    def log_in_via_environment
      self.api_key = ENV.fetch('CLARIFY_API_KEY')
    end

    def clear_api_key
      self.api_key = ''
    end

    def api_key=(val)
      @api_key = val

      @client = nil
    end

    def bundle_repository
      client.bundle_repository
    end

    def restclient
      client.restclient
    end

    def client
      @client ||= Clarify::Client.new(api_key: api_key)
    end
  end
end
