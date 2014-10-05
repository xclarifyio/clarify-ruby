# Clarify

A gem to communicate with the ClarifyAPI.

## Installation

Add this line to your application's Gemfile:

    gem 'clarify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clarify

add a configuration block to an initializer if you are using rails or in an include file:

```
Clarify.configure do |config|
  config.api_key = 'CLARIFY_API_KEY'   
  # if key in ENV   
  # config.api_key = ENV['CLARIFY_API_KEY']
  config.version = 1  #default is latest api version
end
```

It doesn't have to be in ENV variable but that is an option.

**Remember never to check in your API key to a public repository!**

Your API key is found on your [application page](https://developer.clarify.io/apps).

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

    @client = Clarify::Bundle.new ENV['CLARIFY_API_KEY']

    bundle = @client.bundles.create(:name => "Harvard Sentences",
        :media_url => "https://s3-us-west-2.amazonaws.com/op3nvoice/harvard-sentences-1.wav")
    puts bundle.id

## Contributing

1. Fork it to your github user ie: ( `http://github.com/my-github-username/clarify-ruby/` )
2. Create your feature branch and rspec tests (`git checkout -b my-new-feature`)
3. Run the rspec tests with `rake spec`
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

