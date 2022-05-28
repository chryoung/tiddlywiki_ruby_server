FROM ruby:3.1.2-alpine3.16

RUN gem install webrick
RUN mkdir /app
COPY server.rb /app/server.rb
RUN mkdir /data
VOLUME "/data"
WORKDIR /data
ENV MAX_BACKUP=5
CMD ["/usr/local/bin/ruby", "/app/server.rb", "-b", "0.0.0.0", "-m", "$MAX_BACKUP"]
EXPOSE 80
