FROM ruby:2.7
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]
