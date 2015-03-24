
module Clarify
  # The Facade simplifies the configuration and bootstrapping of the client
  # and bundle repository.
  class Facade
    def initialize(config, opts = {})
      @config = config
      @klass_client = opts.fetch(:client, Clarify::Client)
      @klass_configuration = opts.fetch(:configuration, Clarify::Configuration)
      @klass_bundle_repository = opts.fetch(:bundle_repository,
                                            Clarify::BundleRepository)
      @klass_iterator = opts.fetch(:iterator,  Clarify::CollectionIterator)
    end

    def get(url, params = {})
      client.get(url, params)
    end

    def put(url, params = {})
      client.put(url, params)
    end

    def post(url, params = {})
      client.post(url, params)
    end

    def delete(url, params = {})
      client.delete(url, params)
    end

    def pager(collection)
      @klass_iterator.new(client, collection)
    end

    def bundles
      bundle_repository
    end

    def bundle_repository
      @bundle_repository ||= @klass_bundle_repository.new(client)
    end

    def client
      @client ||= @klass_client.new(configuration)
    end

    def configuration
      @configuration ||= @klass_configuration.new(@config)
    end
  end
end
