require 'clarify'
require 'pp'

clarify = Clarify::Facade.new(api_key: 'docs-api-key')

first_page = clarify.bundles.search('flight')
clarify.pager(first_page).each do |result, bundle_url|
  puts " - #{clarify.get(bundle_url).name}"
  pp result
end
