
[![Build Status][travis-image]][travis-url] [![Code Climate][cc-image]][cc-url]

# How To

You can get started in minutes using our Quickstarts:

[http://clarify.io/docs/quickstarts/](http://clarify.io/docs/quickstarts/)

## Basic Setup and Examples

Require the library and initialize the Facade, which takes care of
configuration and client setup.

```ruby
# setup.rb
require 'clarify'
require 'pp'

clarify = Clarify::Facade.new(api_key: 'docs-api-key')
pp clarify
```

### Search for bundles

```ruby
# bundles_search.rb
require 'clarify'

clarify = Clarify::Facade.new(api_key: 'docs-api-key')

results = clarify.bundles.search('plane')

results.each do |bundle_results, bundle_url|
  # Fetch the bundle:
  bundle = clarify.get(bundle_url)

  puts "#{bundle.name} - #{bundle_url}"
  bundle_results['term_results'].each do |term_result|
    term_result['matches'].each do |match|
      type = match['type']
      match['hits'].each do |hit|
        puts "\tmatched #{type} content at #{hit['start']} to #{hit['end']}"
      end
    end
  end
end
```

Example output of bundles_search.rb:
```
<output of bundles_search.rb>
```

### Get a list of bundles

```ruby
# list_bundles.rb
require 'clarify'
clarify = Clarify::Facade.new(api_key: 'docs-api-key')

clarify.bundles.fetch.each do |bundle_url|
  puts " - #{bundle_url}"
end
```

Example output of list_bundles.rb:
```
<output of list_bundles.rb>
```

### Fetch a particular bundle

```ruby
# bundle_fetch.rb
require 'clarify'
require 'pp'

clarify = Clarify::Facade.new(api_key: 'docs-api-key')

bundle_url = '/v1/bundles/3fbca3fe3678495fb08fe939dbe4f1cd'
bundle = clarify.get(bundle_url)
puts "Bundle Name: #{bundle.name}"
pp bundle
```

Example output of bundle_fetch.rb:
```
<output of bundle_fetch.rb>
```

### Get a list of bundles and their names

```ruby
# bundles_list_fetch.rb
require 'clarify'
require 'pp'

clarify = Clarify::Facade.new(api_key: 'docs-api-key')

bundles = clarify.bundles.fetch

bundles.each do |url|
  bundle = clarify.get(url)
  puts " - Bundle Name: #{bundle.name}"
end
```

Example output of bundles_list_fetch.rb:
```
<output of bundles_list_fetch.rb>
```

### Create a bundle

Here you will need your own API key. Creating the bundle will return a 204,
which means it has been Created, but is not done processing.

```ruby
# bundle_create.rb
require 'clarify'
require 'pp'

clarify = Clarify::Facade.new(api_key: ENV['CLARIFY_API_KEY'])

created_bundle = clarify.bundles.create!(
  name: 'Harvard Sentences #1',
  media_url: 'http://media.clarify.io/audio/samples/harvard-sentences-1.wav'
)

pp created_bundle
```

Example output of bundle_create.rb:
```
<output of bundle_create.rb>
```

## More Advanced Usage
#
### Get all of your searches over many pages

```ruby
# searches_paged_over.rb
require 'clarify'
require 'pp'

clarify = Clarify::Facade.new(api_key: 'docs-api-key')

first_page = clarify.bundles.search('flight')
clarify.pager(first_page).each do |result, bundle_url|
  puts " - #{clarify.get(bundle_url).name}"
  pp result
end
```

Example output of searches_paged_over.rb:
```
<output of searches_paged_over.rb>
```

### Get all of your bundles over many pages

```ruby
# bundles_paged_over.rb
require 'clarify'

clarify = Clarify::Facade.new(api_key: 'docs-api-key')

first_page = clarify.bundles.fetch
clarify.pager(first_page).each do |bundle_url|
  puts " - #{clarify.get(bundle_url).name}"
end
```

Example output of bundles_paged_over.rb:
```
<output of bundles_paged_over.rb>
```


[travis-image]: https://travis-ci.org/grahamc/ruby-next.svg
[travis-url]: https://travis-ci.org/grahamc/ruby-next

[cc-image]: https://codeclimate.com/github/grahamc/ruby-next/badges/gpa.svg
[cc-url]: https://codeclimate.com/github/grahamc/ruby-next
