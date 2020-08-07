FROM ruby:2.6.6

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 9292
RUN chmod +x main.rb
CMD ["ruby" "main.rb"]