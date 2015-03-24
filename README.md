
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
The Future of Women in Flying - /v1/bundles/3fbca3fe3678495fb08fe939dbe4f1cd
	matched audio content at 68.92 to 69.31
First American in Earth Orbit - /v1/bundles/72aaa17a9da745c9be41ab64b60319cb
	matched audio content at 99.25 to 99.43
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
 - /v1/bundles/3fbca3fe3678495fb08fe939dbe4f1cd
 - /v1/bundles/2a112c5b3e944802b932b0ddbf068c37
 - /v1/bundles/ca4fbc504c6940cd96f270a0ca903917
 - /v1/bundles/378efa8d163240478ae7d460c20fdb41
 - /v1/bundles/4577432c51ab4fcdbed34be16ba363a2
 - /v1/bundles/72aaa17a9da745c9be41ab64b60319cb
 - /v1/bundles/2a0a63d07c6b46f99638edb961bc08f6
 - /v1/bundles/45a8a6849e1948cea8bbb8dcb3440b68
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
Bundle Name: The Future of Women in Flying
#<Clarify::Responses::Bundle:0x007fda739cd8f8
 @body=
  {"id"=>"3fbca3fe3678495fb08fe939dbe4f1cd",
   "version"=>1,
   "type"=>"audio",
   "name"=>"The Future of Women in Flying",
   "created"=>"2014-04-08T18:37:35.420Z",
   "updated"=>"2014-04-08T18:37:35.420Z",
   "_class"=>"Bundle",
   "_links"=>
    {"self"=>{"href"=>"/v1/bundles/3fbca3fe3678495fb08fe939dbe4f1cd"},
     "curies"=>
      [{"href"=>"/docs/rels/{rel}", "name"=>"clarify", "templated"=>true}],
     "clarify:metadata"=>
      {"href"=>"/v1/bundles/3fbca3fe3678495fb08fe939dbe4f1cd/metadata"},
     "clarify:tracks"=>
      {"href"=>"/v1/bundles/3fbca3fe3678495fb08fe939dbe4f1cd/tracks"}}},
 @response=#<Net::HTTPOK 200 OK readbody=true>>
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
 - Bundle Name: The Future of Women in Flying
 - Bundle Name: Election Eve Campaign Speech
 - Bundle Name: Address to the Women of America
 - Bundle Name: Address to Congress - Baseball
 - Bundle Name: On Black Power
 - Bundle Name: First American in Earth Orbit
 - Bundle Name: On Releasing the Watergate Tapes
 - Bundle Name: Resignation Address
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
#<Clarify::Response:0x007fc597030728
 @body=
  {"id"=>"4ef898e427ee48b28f939785c3c718a2",
   "_class"=>"Ref",
   "_links"=>
    {"self"=>{"href"=>"/v1/bundles/4ef898e427ee48b28f939785c3c718a2"},
     "curies"=>
      [{"href"=>"/docs/rels/{rel}", "name"=>"clarify", "templated"=>true}],
     "clarify:metadata"=>
      {"href"=>"/v1/bundles/4ef898e427ee48b28f939785c3c718a2/metadata"},
     "clarify:tracks"=>
      {"href"=>"/v1/bundles/4ef898e427ee48b28f939785c3c718a2/tracks"}}},
 @response=#<Net::HTTPCreated 201 Created readbody=true>>
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
 - First American in Earth Orbit
{"score"=>1,
 "term_results"=>
  [{"score"=>0.379,
    "matches"=>
     [{"type"=>"audio",
       "track"=>0,
       "hits"=>
        [{"start"=>67.41, "end"=>67.55}, {"start"=>92.76, "end"=>92.94}]}]}]}
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
 - The Future of Women in Flying
 - Election Eve Campaign Speech
 - Address to the Women of America
 - Address to Congress - Baseball
 - On Black Power
 - First American in Earth Orbit
 - On Releasing the Watergate Tapes
 - Resignation Address
```


[travis-image]: https://travis-ci.org/Clarify/clarify-ruby.svg
[travis-url]: https://travis-ci.org/Clarify/clarify-ruby

[cc-image]: https://codeclimate.com/github/Clarify/clarify-ruby/badges/gpa.svg
[cc-url]: https://codeclimate.com/github/Clarify/clarify-ruby
