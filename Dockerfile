FROM ruby:3.2.2-alpine3.17

ENV BUNDLER_VERSION=2.1.4

COPY . /app
WORKDIR /app

RUN apk update && apk add --virtual build-dependencies build-base
RUN bundle install

EXPOSE 4000

CMD bundle exec jekyll serve --watch --host 0.0.0.0