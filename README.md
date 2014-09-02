# Clarify

A gem to communicate with the ClarifyAPI.

## Installation

Add this line to your application's Gemfile:

    gem 'clarify_api', require: 'clarify-ruby' 

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clarify

Add `CLARIFY_API_KEY` as an environment variable. It is found on your [application page](https://developer.clarify.io/apps).

In bash:

    export CLARIFY_API_KEY=atYIFLDSDFsdfssSsd+fsfsdfsd+p+PCwA

If you don't want to load it in your bash file, you can add it on the command line:

    CLARIFY_API_KEY=atYIFLDSDFsdfssSsd+fsfsdfsd+p+PCwA rails s

Or on [Heroku](http://www.heroku)

    heroku config:set CLARIFY_API_KEY=atYIFLDSDFsdfssSsd+fsfsdfsd+p+PCwA

[Read more on heroku environment variables](https://devcenter.heroku.com/articles/config-vars)

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/my-github-username/clarify-ruby/fork )
2. Create your feature branch and rspec tests (`git checkout -b my-new-feature`)
3. Run the rspec tests with `rake spec`
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

