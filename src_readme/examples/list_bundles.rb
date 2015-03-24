require 'clarify'
clarify = Clarify::Facade.new(api_key: 'docs-api-key')

clarify.bundles.fetch.each do |bundle_url|
  puts " - #{bundle_url}"
end
