FROM ruby:2.4
WORKDIR /home
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install
ADD . /home
EXPOSE 9292
CMD 'puma'


