
[![Build Status][travis-image]][travis-url] [![Code Climate][cc-image]][cc-url]

# How To

You can get started in minutes using our Quickstarts:

[http://clarify.io/docs/quickstarts/](http://clarify.io/docs/quickstarts/)

## Basic Setup and Examples

Require the library and initialize the Client, which takes care of
configuration and http client setup.

```ruby
# setup.rb
require 'clarify'
require 'pp'

clarify = Clarify::Client.new(api_key: 'docs-api-key')
pp clarify
```

### Search for bundles

```ruby
# bundles_search.rb
require 'clarify'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

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
Obama-2004-DNC-Keynote - /v1/bundles/51ee9932989c47d3adf734c4e467c83f
	matched audio content at 951.62 to 951.82
How-Schools-Kill-Creativity - /v1/bundles/6864abafeee8458bb9902628ee270cae
	matched audio content at 485.92 to 486.11
The-Surprising-Science-of-Happiness - /v1/bundles/d6dcddf1066b4dd4bed78334e553e233
	matched audio content at 80.94 to 81.57
```

### Get a list of bundles

```ruby
# list_bundles.rb
require 'clarify'
clarify = Clarify::Client.new(api_key: 'docs-api-key')

clarify.bundles.fetch.each do |bundle_url|
  puts " - #{bundle_url}"
end
```

Example output of list_bundles.rb:
```
 - /v1/bundles/d6dcddf1066b4dd4bed78334e553e233
 - /v1/bundles/f87a4e7928a84cf192091a337dbbdd80
 - /v1/bundles/cbc77abbc54e4cc686d65156fe1d29a3
 - /v1/bundles/6864abafeee8458bb9902628ee270cae
 - /v1/bundles/75afdd5a5af74a559b8381c22ead1047
 - /v1/bundles/ae5fbaa351e44897a211c0c9f097ffba
 - /v1/bundles/0e81c313755248e3860c6f569498eb84
 - /v1/bundles/f145f401d14442c1838d04764c5a5bf1
 - /v1/bundles/41266fd35e6f4cf78c6040dd24b9c34d
 - /v1/bundles/68bca9f916e846c79ccd2b8079afc2f4
```

### Fetch a particular bundle

```ruby
# bundle_fetch.rb
require 'clarify'
require 'pp'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

bundle_url = '/v1/bundles/d6dcddf1066b4dd4bed78334e553e233'
bundle = clarify.get(bundle_url)
puts "Bundle Name: #{bundle.name}"
pp bundle
```

Example output of bundle_fetch.rb:
```
Bundle Name: The-Surprising-Science-of-Happiness
#<Clarify::Responses::Bundle:0x007f65808368b8
 @body=
  {"id"=>"d6dcddf1066b4dd4bed78334e553e233",
   "version"=>1,
   "name"=>"The-Surprising-Science-of-Happiness",
   "created"=>"2015-04-21T18:13:47.377Z",
   "updated"=>"2015-04-21T18:13:47.377Z",
   "_class"=>"Bundle",
   "_links"=>
    {"self"=>{"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233"},
     "curies"=>
      [{"href"=>"/docs/rels/{rel}", "name"=>"clarify", "templated"=>true}],
     "clarify:metadata"=>
      {"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/metadata"},
     "clarify:tracks"=>
      {"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/tracks"},
     "clarify:insights"=>
      {"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights"}}},
 @response=#<Net::HTTPOK 200 OK readbody=true>>
```

### Fetch a particular bundle's insight list

```ruby
# bundle_insight_list.rb
require 'clarify'
require 'pp'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

bundle_url = '/v1/bundles/d6dcddf1066b4dd4bed78334e553e233'
bundle = clarify.get(bundle_url)

bundle_insights_url = bundle.relation('clarify:insights')

puts "Insights for Bundle Name: #{bundle.name} (#{bundle_insights_url})"
insights = clarify.get(bundle_insights_url)
pp insights
puts '-----------'
insights.each do |insight, insight_url|
  puts "Insight #{insight} (#{insight_url})"
  insight = clarify.get(insight_url)
  pp insight
  puts ''
  puts ''
  puts ''
end
```

Example output of bundle_insight_list.rb:
```
Insights for Bundle Name: The-Surprising-Science-of-Happiness (/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights)
#<Clarify::Responses::Insights:0x007f710e256760
 @body=
  {"bundle_id"=>"d6dcddf1066b4dd4bed78334e553e233",
   "created"=>"2015-04-21T18:13:47.388Z",
   "updated"=>"2015-05-16T20:39:27.740Z",
   "_class"=>"Insights",
   "_links"=>
    {"self"=>{"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights"},
     "parent"=>{"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233"},
     "insight:spoken_words"=>
      {"href"=>
        "/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights/c1ea412ef6aa434dbe05df12f97b9f89"},
     "insight:spoken_keywords"=>
      {"href"=>
        "/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights/b83668e8089148b7a5c96b1b045637ec"},
     "curies"=>
      [{"href"=>"/docs/insights/{rel}",
        "name"=>"insight",
        "templated"=>true}]}},
 @response=#<Net::HTTPOK 200 OK readbody=true>>
-----------
Insight insight:spoken_words (/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights/c1ea412ef6aa434dbe05df12f97b9f89)
#<Clarify::Responses::SpokenWordsInsight:0x007f710e226b78
 @body=
  {"id"=>"c1ea412ef6aa434dbe05df12f97b9f89",
   "bundle_id"=>"d6dcddf1066b4dd4bed78334e553e233",
   "name"=>"spoken_words",
   "status"=>"ready",
   "created"=>"2015-04-21T18:13:50.087Z",
   "updated"=>"2015-04-21T18:13:50.090Z",
   "track_data"=>
    [{"spoken_duration"=>1189.48,
      "word_count"=>3709,
      "spoken_duration_percent"=>0.93}],
   "_class"=>"SpokenWordsInsight",
   "_links"=>
    {"self"=>
      {"href"=>
        "/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights/c1ea412ef6aa434dbe05df12f97b9f89"},
     "curies"=>
      [{"href"=>"/docs/rels/{rel}", "name"=>"clarify", "templated"=>true}],
     "parent"=>
      {"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights"},
     "clarify:bundle"=>
      {"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233"}}},
 @response=#<Net::HTTPOK 200 OK readbody=true>>



Insight insight:spoken_keywords (/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights/b83668e8089148b7a5c96b1b045637ec)
#<Clarify::Responses::SpokenKeywordsInsight:0x007f710e197ea0
 @body=
  {"id"=>"b83668e8089148b7a5c96b1b045637ec",
   "bundle_id"=>"d6dcddf1066b4dd4bed78334e553e233",
   "name"=>"spoken_keywords",
   "status"=>"ready",
   "created"=>"2015-05-16T20:39:27.739Z",
   "updated"=>"2015-05-16T20:39:27.741Z",
   "track_data"=>
    [{"keywords"=>
       [{"term"=>"one", "count"=>43, "weight"=>1},
        {"term"=>"happiness", "count"=>27, "weight"=>0.628},
        {"term"=>"like", "count"=>23, "weight"=>0.535},
        {"term"=>"can", "count"=>20, "weight"=>0.465},
        {"term"=>"know", "count"=>18, "weight"=>0.419},
        {"term"=>"people", "count"=>17, "weight"=>0.395},
        {"term"=>"really", "count"=>16, "weight"=>0.372},
        {"term"=>"right", "count"=>15, "weight"=>0.349},
        {"term"=>"2", "count"=>14, "weight"=>0.326},
        {"term"=>"make", "count"=>13, "weight"=>0.302},
        {"term"=>"change", "count"=>13, "weight"=>0.302},
        {"term"=>"us", "count"=>12, "weight"=>0.279},
        {"term"=>"say", "count"=>11, "weight"=>0.256},
        {"term"=>"just", "count"=>11, "weight"=>0.256},
        {"term"=>"better", "count"=>10, "weight"=>0.233},
        {"term"=>"much", "count"=>10, "weight"=>0.233},
        {"term"=>"now", "count"=>10, "weight"=>0.233},
        {"term"=>"course", "count"=>10, "weight"=>0.233},
        {"term"=>"3", "count"=>10, "weight"=>0.233},
        {"term"=>"get", "count"=>9, "weight"=>0.209}]}],
   "_class"=>"SpokenKeywordsInsight",
   "_links"=>
    {"self"=>
      {"href"=>
        "/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights/b83668e8089148b7a5c96b1b045637ec"},
     "curies"=>
      [{"href"=>"/docs/rels/{rel}", "name"=>"clarify", "templated"=>true}],
     "parent"=>
      {"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233/insights"},
     "clarify:bundle"=>
      {"href"=>"/v1/bundles/d6dcddf1066b4dd4bed78334e553e233"}}},
 @response=#<Net::HTTPOK 200 OK readbody=true>>



```

### Get a list of bundles and their names

```ruby
# bundles_list_fetch.rb
require 'clarify'
require 'pp'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

bundles = clarify.bundles.fetch

bundles.each do |url|
  bundle = clarify.get(url)
  puts " - Bundle Name: #{bundle.name}"
end
```

Example output of bundles_list_fetch.rb:
```
 - Bundle Name: The-Surprising-Science-of-Happiness
 - Bundle Name: GWB-2004-Victory-Speech
 - Bundle Name: harvard-sentences-2
 - Bundle Name: How-Schools-Kill-Creativity
 - Bundle Name: MLK-I-Have-a-Dream
 - Bundle Name: dorothyandthewizardinoz_01
 - Bundle Name: How-Great-Leaders-Inspire-Action
 - Bundle Name: The-Happy-Secret-to-Better-Work
 - Bundle Name: FDR-Statue-of-Liberty
 - Bundle Name: Reagan-Challenger-Disaster
```

### Get a list of tracks and the URL of their original media

```ruby
# bundles_show_tracks.rb
require 'clarify'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

clarify.bundles.fetch.each do |bundle_url|
  tracks_url = clarify.get(bundle_url).relation('clarify:tracks')

  clarify.get(tracks_url).each do |track|
    puts " - #{track['media_url']}"
  end
end
```

Example output of bundles_show_tracks.rb:
```
 - http://media.clarify.io/video/presentations/DanGilbert-TED2004-The-Surprising-Science-of-Happiness.mp4
 - http://media.clarify.io/audio/speeches/GWB-2004-Victory-Speech.mp3
 - http://media.clarify.io/audio/samples/harvard-sentences-2.wav
 - http://media.clarify.io/video/presentations/SirKenRobinson-TED2006-How-Schools-Kill-Creativity.mp4
 - http://media.clarify.io/audio/speeches/MLK-I-Have-a-Dream.mp3
 - http://media.clarify.io/audio/books/dorothyandthewizardinoz_01_baum_64kb.mp3
 - http://media.clarify.io/video/presentations/SimonSinek-TEDxPugetSound-How-Great-Leaders-Inspire-Action.mp4
 - http://media.clarify.io/video/presentations/ShawnAchor-TEDxBloomington-The-Happy-Secret-to-Better-Work.mp4
 - http://media.clarify.io/audio/speeches/FDR-Statue-of-Liberty.mp3
 - http://media.clarify.io/audio/speeches/Reagan-Challenger-Disaster.mp3
```

### Create a bundle

Here you will need your own API key. Creating the bundle will return a 204,
which means it has been Created, but is not done processing.

```ruby
# bundle_create.rb
require 'clarify'
require 'pp'

clarify = Clarify::Client.new(api_key: ENV['CLARIFY_API_KEY'])

created_bundle = clarify.bundles.create!(
  name: 'Harvard Sentences #1',
  media_url: 'http://media.clarify.io/audio/samples/harvard-sentences-1.wav'
)

pp created_bundle
```

Example output of bundle_create.rb:
```
#<Clarify::Response:0x007fd0740a7278
 @body=
  {"id"=>"1bf2f176592144398d799bfa2298f629",
   "_class"=>"Ref",
   "_links"=>
    {"self"=>{"href"=>"/v1/bundles/1bf2f176592144398d799bfa2298f629"},
     "curies"=>
      [{"href"=>"/docs/rels/{rel}", "name"=>"clarify", "templated"=>true}],
     "clarify:metadata"=>
      {"href"=>"/v1/bundles/1bf2f176592144398d799bfa2298f629/metadata"},
     "clarify:tracks"=>
      {"href"=>"/v1/bundles/1bf2f176592144398d799bfa2298f629/tracks"},
     "clarify:insights"=>
      {"href"=>"/v1/bundles/1bf2f176592144398d799bfa2298f629/insights"}}},
 @response=#<Net::HTTPCreated 201 Created readbody=true>>
```

## More Advanced Usage
#
### Get all of your searches over many pages

```ruby
# searches_paged_over.rb
require 'clarify'
require 'pp'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

first_page = clarify.bundles.search('flight')
clarify.pager(first_page).each do |result, bundle_url|
  puts " - #{clarify.get(bundle_url).name}"
  pp result
end
```

Example output of searches_paged_over.rb:
```
 - Reagan-Challenger-Disaster
{"score"=>1,
 "term_results"=>
  [{"score"=>0.34,
    "matches"=>
     [{"type"=>"audio",
       "track"=>0,
       "hits"=>
        [{"start"=>34.29, "end"=>34.71}, {"start"=>172.59, "end"=>173.2}]}]}]}
 - How-Great-Leaders-Inspire-Action
{"score"=>0.632,
 "term_results"=>
  [{"score"=>0.286,
    "matches"=>
     [{"type"=>"audio",
       "track"=>0,
       "hits"=>
        [{"start"=>64.53, "end"=>65},
         {"start"=>72.9, "end"=>73.12},
         {"start"=>502.59, "end"=>502.81},
         {"start"=>625.4, "end"=>625.65},
         {"start"=>637.97, "end"=>638.25}]}]}]}
 - FDR-Statue-of-Liberty
{"score"=>0.566,
 "term_results"=>
  [{"score"=>0.155,
    "matches"=>
     [{"type"=>"audio",
       "track"=>0,
       "hits"=>[{"start"=>48.47, "end"=>48.73}]}]}]}
 - The-Happy-Secret-to-Better-Work
{"score"=>0.354,
 "term_results"=>
  [{"score"=>0.097,
    "matches"=>
     [{"type"=>"audio",
       "track"=>0,
       "hits"=>[{"start"=>652.78, "end"=>653.05}]}]}]}
 - The-Surprising-Science-of-Happiness
{"score"=>0.283,
 "term_results"=>
  [{"score"=>0.078,
    "matches"=>
     [{"type"=>"audio",
       "track"=>0,
       "hits"=>[{"start"=>78.05, "end"=>78.39}]}]}]}
 - On-the-Edge-of-Hypermedia
{"score"=>0.212,
 "term_results"=>
  [{"score"=>0.058,
    "matches"=>
     [{"type"=>"audio",
       "track"=>0,
       "hits"=>[{"start"=>2083.62, "end"=>2084.12}]}]}]}
```

### Get all of your bundles over many pages

```ruby
# bundles_paged_over.rb
require 'clarify'

clarify = Clarify::Client.new(api_key: 'docs-api-key')

first_page = clarify.bundles.fetch
clarify.pager(first_page).each do |bundle_url|
  puts " - #{clarify.get(bundle_url).name}"
end
```

Example output of bundles_paged_over.rb:
```
 - The-Surprising-Science-of-Happiness
 - GWB-2004-Victory-Speech
 - harvard-sentences-2
 - How-Schools-Kill-Creativity
 - MLK-I-Have-a-Dream
 - dorothyandthewizardinoz_01
 - How-Great-Leaders-Inspire-Action
 - The-Happy-Secret-to-Better-Work
 - FDR-Statue-of-Liberty
 - Reagan-Challenger-Disaster
 - Obama-2008-DNC-Speech
 - GWB-2000-Victory-Speech
 - Obama-2004-DNC-Keynote
 - FDR-Inaugural-Address
 - Mission-Critical-Innovation
 - On-the-Edge-of-Hypermedia
 - harvard-sentences-1
```


[travis-image]: https://travis-ci.org/Clarify/clarify-ruby.svg
[travis-url]: https://travis-ci.org/Clarify/clarify-ruby

[cc-image]: https://codeclimate.com/github/Clarify/clarify-ruby/badges/gpa.svg
[cc-url]: https://codeclimate.com/github/Clarify/clarify-ruby
