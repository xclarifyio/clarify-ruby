
module Clarify
  # The Client simplifies the configuration and bootstrapping of the restclient
  # and bundle repository.
  class Client
    def initialize(config, opts = {})
      @config = config
      @klass_restclient = opts.fetch(:rest_client, Clarify::RestClient)
      @klass_configuration = opts.fetch(:configuration, Clarify::Configuration)
      @klass_bundle_repository = opts.fetch(:bundle_repository,
                                            Clarify::BundleRepository)
      @klass_iterator = opts.fetch(:iterator,  Clarify::CollectionIterator)
    end

    def get(url, params = {})
      restclient.get(url, params)
    end

    def put(url, params = {})
      restclient.put(url, params)
    end

    def post(url, params = {})
      restclient.post(url, params)
    end

    def delete(url, params = {})
      restclient.delete(url, params)
    end

    def pager(collection)
      @klass_iterator.new(restclient, collection)
    end

    def bundles
      bundle_repository
    end

    def bundle_repository
      @bundle_repository ||= @klass_bundle_repository.new(restclient)
    end

    def restclient
      @restclient ||= @klass_restclient.new(configuration)
    end

    def configuration
      @configuration ||= @klass_configuration.new(@config)
    end
  end
end
