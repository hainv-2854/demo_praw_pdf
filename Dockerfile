FROM ruby:3.1.0
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /demo_praw_pdf

WORKDIR /demo_praw_pdf

ADD Gemfile /demo_praw_pdf/Gemfile
ADD Gemfile.lock /demo_praw_pdf/Gemfile.lock

# RUN gem install bundler -v 2.1.4 -no-rdoc -no-ri
RUN bundle install
ADD . /demo_praw_pdf

EXPOSE 3001
