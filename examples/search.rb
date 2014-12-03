
require 'rubygems'
require 'clarify'

# This assumes that you set up your key in the environment using: export CLARIFY_API_KEY=abcde12345
Clarify.configure do |config|
  # config.api_key = 'CLARIFY_API_KEY'
  # if key in ENV
  config.api_key = ENV['CLARIFY_API_KEY']
  config.version = 1  #default is latest api version
end

@client = Clarify::Search.new
results = @client.perform(:query => "dorothy").data
bundles = results[:_links][:items]

_bundle = Clarify::Bundle.new

bundles.each do |bundle|
  _id = bundle[:href][12..44]
  test = _bundle.find(_id)
  puts test.data[:name]
  i = bundles.find_index(bundle)
  matches = results[:item_results][i][:term_results][0][:matches][0][:hits]
  matches.each do |match|
    puts match[:start].to_s + " -- " + match[:end].to_s
  end
end