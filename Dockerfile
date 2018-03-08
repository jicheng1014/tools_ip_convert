FROM ruby:2.4
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
WORKDIR /home
RUN gem install bundler
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install
ADD . /home
EXPOSE 9292
CMD ["bundle", "exec", "puma", "-e", "production"]


