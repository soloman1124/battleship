FROM ruby:1.9.3
MAINTAINER Soloman Weng "soloman1124@gmail.com"
ENV REFRESHED_AT 2015-07-05

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/
RUN bundle install

ADD . /usr/src/app

EXPOSE 8080
CMD ["bundle", "rackup", "-p", "8080"]
