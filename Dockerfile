FROM dannyben/alpine-ruby:3.2.2

RUN gem install madness -v 1.1.2

WORKDIR /docs

VOLUME /docs

EXPOSE 3000

ENTRYPOINT ["madness"]