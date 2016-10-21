FROM xiangpeng/alpine-ruby:latest
RUN mkdir -p /usr/src/Gemfile
WORKDIR /usr/src/Gemfile
ENV BUILD_PACKAGES="curl-dev build-base openssh" \
    DEV_PACKAGES="tzdata libxml2 libxml2-dev libxslt libxslt-dev postgresql-client \
                  imagemagick imagemagick-dev nodejs" 

RUN \
  apk --update --upgrade add $BUILD_PACKAGES $DEV_PACKAGES && \
  rm /var/cache/apk/*

RUN gem source -r https://rubygems.org/
RUN gem source -a https://gems.ruby-china.org
ONBUILD COPY Gemfile .
ONBUILD COPY Gemfile.lock .
ONBUILD RUN bundle install