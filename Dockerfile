FROM ruby:latest

RUN mkdir -p /data/lib/clarify/
WORKDIR /data
ADD Gemfile clarify.gemspec /data/
ADD lib/clarify/version.rb /data/lib/clarify/version.rb
RUN bundle install

ADD features /data/features

ENTRYPOINT [ "rake" ]
