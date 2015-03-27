
require 'net/http'
require 'json'
require 'uri'

module Clarify
  # Implement the HTTP layer. All the communication in this restclient goes over
  # the one HTTP connection for performance. The connection is created by the
  # input of the Configuration object which is passed in by default.
  #
  # This is a bit over complex, but deals with:
  #
  #  1. Authenticating and identifying (via UserAgent) requests ("blessing")
  #  2. Actually calling the API over HTTP
  #  3. Converting the resulting responses into Response objects
  #
  # In other words, this does too many things, but it is a start.
  class RestClient
    attr_reader :config

    def initialize(config)
      @config = config
      @cached = {}
    end

    def get(url, params = {})
      request(get_request(url, params))
    end

    def post(url, params = {})
      request(post_request(url, params))
    end

    def put(url, params = {})
      request(put_request(url, params))
    end

    def delete(url, params = {})
      request(delete_request(url, params))
    end

    def get_request(url, params = {})
      url = make_get_url(url, params)
      Net::HTTP::Get.new(url)
    end

    def post_request(url, body = {})
      request = Net::HTTP::Post.new(url)
      request.set_form_data(body)
      request
    end

    def put_request(url, body = {})
      request = Net::HTTP::Put.new(url)
      request.set_form_data(body)
      request
    end

    def delete_request(url, body = {})
      request = Net::HTTP::Delete.new(url)
      request.set_form_data(body)
      request
    end

    def make_get_url(url, parameters)
      # Convert the URL to a URI object we can manipulate
      uri = URI.parse(url)

      # Code a=b to [['a', 'b']] -- this array of arrays format is used
      # so you can represent (valid) URLs which look like:
      # a=b&a=c via [['a', 'b'], ['a', 'c']]
      original_params = URI.decode_www_form(uri.query.to_s)

      # Now we convert the incoming URL parameters which could either look like:
      # 1. { b: 'c' }
      # 2. { b: ['c', 'd'] }
      # 3. { b: :c }
      # 4. [['b', 'c']]
      # to consistently be in the fourth format by encoding (flexible on input)
      # and decoding again (which always produces the fourth format.)
      new_params = URI.decode_www_form(URI.encode_www_form(parameters))

      # Merge the two arrays [['b', 'c']] and [['a', 'b']] into
      # [['a', 'b'], ['b', 'c']] and put it into the uri object for returning
      uri.query = URI.encode_www_form(original_params + new_params)

      # Set the query to nil if the query is empty, otherwise the generated URL
      # will have a trailing ?.
      uri.query = nil if uri.query.empty?

      uri.to_s
    end

    def request(request)
      request = bless_request(request)
      response = connection.request(request)
      make_result(response)
    end

    def bless_request(request)
      request['Authorization'] = "Bearer #{config.api_key}" if config.api_key?
      request['User-Agent'] = user_agent

      request
    end

    def user_agent
      ruby_version = "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
      "clarify-ruby/#{Clarify::VERSION}/#{ruby_version}"
    end

    def make_result(response)
      response_factory.make_result(response)
    end

    def response_factory
      @response_factory ||= Clarify::ResponseFactory.new
    end

    def connection
      unless @connection
        @connection ||= Net::HTTP.new(config.host, config.port)
        @connection.use_ssl = config.ssl?
      end

      @connection
    end
  end
end
