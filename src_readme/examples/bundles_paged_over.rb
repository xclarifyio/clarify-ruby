require 'clarify'

clarify = Clarify::Facade.new(api_key: 'docs-api-key')

first_page = clarify.bundles.fetch
clarify.pager(first_page).each do |bundle_url|
  puts " - #{clarify.get(bundle_url).name}"
end
