FROM ruby:2.4
ADD docker_config/sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y vim curl htop
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

WORKDIR /home
RUN gem install bundler
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install
ADD . /home
EXPOSE 9292
CMD ["bundle", "exec", "puma", "-e", "production"]


