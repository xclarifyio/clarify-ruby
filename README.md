[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/Clarify/clarify-ruby/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/Clarify/clarify-ruby/?branch=master) [![Code Climate](https://codeclimate.com/github/Clarify/clarify-ruby/badges/gpa.svg)](https://codeclimate.com/github/Clarify/clarify-ruby)

# Clarify

A gem to communicate with the ClarifyAPI.

### Installation

Add this line to your application's Gemfile:

    gem 'clarify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clarify

add a configuration block to an initializer if you are using rails or in an include file:

```
require 'clarify'

Clarify.configure do |config|
  config.api_key = 'CLARIFY_API_KEY'   
  # if key in ENV   
  # config.api_key = ENV['CLARIFY_API_KEY']
  config.version = 1  #default is latest api version
end
```

It doesn't have to be in ENV variable but that is an option.

**Remember never to check in your API key to a public repository!**

Your API key is found on your [application page](https://developer.clarify.io/apps/list/).

If you wish to store your API key in your environment:

In bash:

    export CLARIFY_API_KEY=atYIFLDSDFsdfssSsd+fsfsdfsd+p+PCwA

If you don't want to load it in your bash file, you can add it on the command line:

    CLARIFY_API_KEY=atYIFLDSDFsdfssSsd+fsfsdfsd+p+PCwA rails s

Or on [Heroku](http://www.heroku)

    heroku config:set CLARIFY_API_KEY=atYIFLDSDFsdfssSsd+fsfsdfsd+p+PCwA

[Read more on heroku environment variables](https://devcenter.heroku.com/articles/config-vars)

By default, it uses the newest version of the API.

## Usage

To begin using this library, initialize the Clarify object with your API key:

```ruby
require 'clarify'
client = Clarify::Bundle.new
```

Then add an audio or video file to your search index:

```ruby
bundle = client.create(:name => "Harvard Sentences",
        :media_url => "http://media.clarify.io/audio/samples/harvard-sentences-1.wav")
bundle.data[:id]
```

Within minutes your file will be added to your index and available via a simple search:

```ruby
client = Clarify::Search.new
results = client.perform(:query => "dorothy").data
bundles = results[:_links][:items]
```

See more examples for listing, getting, and deleting bundles etc. in the /examples folder.

## Contributing

1. Fork it to your github user ie: ( `http://github.com/my-github-username/clarify-ruby/` )
2. Create your feature branch and rspec tests (`git checkout -b my-new-feature`)
3. Run the rspec tests with `rake spec`
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

