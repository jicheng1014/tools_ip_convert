FROM ruby:2.4
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
WORKDIR /home
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install
ADD . /home
EXPOSE 9292
CMD 'puma'


