
require "clarify"
require "debugger"

Clarify.configure do |config|
  config.api_key = ENV['CLARIFY_API_KEY']
end


RSpec.configure do |config|
  config.order = :random
end
