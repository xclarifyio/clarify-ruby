module Clarify
  # A general purpose response which handles status code access and accessing
  # link relations.
  class Response
    attr_reader :body
    attr_reader :response

    def initialize(body, response)
      @body = body
      @response = response
    end

    def http_status_code
      response.code.to_i
    end

    def relation!(link)
      url = relation(link)

      fail ArgumentError, "Link '#{link}' not present" if url.nil?

      url
    end

    def relation(link)
      body.fetch('_links', {}).fetch(link, {}).fetch('href', nil)
    end
  end
end
