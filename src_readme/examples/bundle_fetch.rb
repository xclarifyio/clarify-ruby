require 'clarify'
require 'pp'

clarify = Clarify::Facade.new(api_key: 'docs-api-key')

bundle_url = '/v1/bundles/3fbca3fe3678495fb08fe939dbe4f1cd'
bundle = clarify.get(bundle_url)
puts "Bundle Name: #{bundle.name}"
pp bundle
