require 'clarify'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

clarify.bundles.fetch.each do |bundle_url|
  tracks_url = clarify.get(bundle_url).relation('clarify:tracks')

  clarify.get(tracks_url).each do |track|
    puts " - #{track['media_url']}"
  end
end
