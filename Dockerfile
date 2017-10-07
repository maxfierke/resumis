FROM ruby:2.4-alpine3.6
LABEL maintainer="Max Fierke <max@maxfierke.com>" \
      description="An API for your personal site & resume"

ENV APP_HOME=/resumis \
    RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RESUMIS_DEPLOY_ROOT=/resumis \
    RESUMIS_TENANCY_MODE=single \
    RESUMIS_USER=resumis \
    PORT=5000

EXPOSE 5000

RUN addgroup $RESUMIS_USER && adduser -h $APP_HOME -s /bin/sh -D -G $RESUMIS_USER $RESUMIS_USER

RUN apk add --update --no-cache \
  build-base \
  linux-headers \
  nodejs \
  tzdata \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev

RUN mkdir -p $APP_HOME/shared/pids
WORKDIR $APP_HOME

ADD ./Gemfile* $APP_HOME/
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install -j$(getconf _NPROCESSORS_ONLN) --deployment --without test development

ADD . $APP_HOME

RUN rake assets:precompile

RUN chown -R $RESUMIS_USER:$RESUMIS_USER $APP_HOME

USER $RESUMIS_USER

CMD [ "bundle", "exec", "unicorn", "-c", "config/unicorn.rb" ]
