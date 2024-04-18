FROM dannyben/alpine-ruby:3.2.2

RUN apk add --no-cache pandoc

RUN gem install madness -v 1.2.0

WORKDIR /docs

VOLUME /docs

EXPOSE 3000

ENTRYPOINT ["madness"]