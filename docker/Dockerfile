FROM ruby:latest

LABEL maintainer="dragonchaser <maptool@datenschmutz.space>"
EXPOSE 4567
COPY . /maptool
WORKDIR /maptool
RUN bundle install
CMD ["ruby", "app.rb"]
