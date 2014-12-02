
require 'rubygems'
require 'clarify'

# This assumes that you set up your key in the environment using: export CLARIFY_API_KEY=abcde12345
Clarify.configure do |config|
  # config.api_key = 'CLARIFY_API_KEY'
  # if key in ENV
  config.api_key = ENV['CLARIFY_API_KEY']
  config.version = 1  #default is latest api version
end

@client = Clarify::Bundle.new
@client.delete("abc123")