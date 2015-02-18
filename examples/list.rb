
require 'clarify'

# This assumes that you set up your key in the environment using: export CLARIFY_API_KEY=abcde12345
Clarify.configure do |config|
  # config.api_key = 'CLARIFY_API_KEY'
  # if key in ENV
  config.api_key = ENV['CLARIFY_API_KEY']
end

client = Clarify::Bundle.new

bundles = client.find_all.data[:_links][:items]
bundles.each { |bundle| puts bundle[:href]  }