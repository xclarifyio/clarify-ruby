require 'clarify'
require 'pp'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

bundle_url = '/v1/bundles/d6dcddf1066b4dd4bed78334e553e233'
bundle = clarify.get(bundle_url)
puts "Bundle Name: #{bundle.name}"
pp bundle
