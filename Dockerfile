FROM ruby:2.3.4-slim

RUN apt-get update -qq && \
      apt-get install --no-install-recommends --fix-missing -y \
      build-essential \
      git \
      libpq-dev \
      postgresql-client \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

ENV APP_HOME=/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

EXPOSE 80
ENV HOST=0.0.0.0 PORT=80 LANG=C.UTF-8

RUN gem update --system 2.6.10
RUN gem install bundler -v 1.13.7

ADD Gemfile Gemfile.lock $APP_HOME/
RUN bundle install

VOLUME /usr/local/bundle

ADD . $APP_HOME

CMD ["puma", "-C", "config/puma.rb"]
