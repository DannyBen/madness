FROM dannyben/alpine-ruby:3.3.3

ENV PS1 "\n\n>> madness \W \$ "
RUN apk add --no-cache git

ARG branch=master

WORKDIR /madness
RUN git clone --branch $branch --depth 1 https://github.com/DannyBen/madness.git .
RUN gem build madness.gemspec
RUN gem install madness*.gem

WORKDIR /docs
RUN rm -rf /madness

VOLUME /docs
EXPOSE 3000
ENTRYPOINT ["madness"]