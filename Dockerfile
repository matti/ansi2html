FROM ruby:2.3.1-alpine

RUN mkdir /app
WORKDIR /app

ADD Gemfile .
ADD Gemfile.lock .

RUN gem install bundler

RUN apk update

RUN apk add --virtual \
  build-dependencies build-base \
  linux-headers && \
  bundle install --without development test && \
  apk del build-dependencies

ADD . /app/

RUN adduser -D app
USER app

EXPOSE 4567

CMD bundle exec rackup -o 0.0.0.0 -p $PORT
