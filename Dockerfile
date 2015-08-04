FROM ruby:latest

RUN mkdir -p /data
WORKDIR /data
ADD . /data/
RUN bundle install


ENTRYPOINT [ "rake" ]
