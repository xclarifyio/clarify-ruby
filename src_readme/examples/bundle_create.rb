require 'clarify'
require 'pp'

clarify = Clarify::Facade.new(api_key: ENV['CLARIFY_API_KEY'])

created_bundle = clarify.bundles.create!(
  name: 'Harvard Sentences #1',
  media_url: 'http://media.clarify.io/audio/samples/harvard-sentences-1.wav'
)

pp created_bundle
