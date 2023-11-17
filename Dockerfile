FROM ruby:3.2.2-alpine3.18 AS builder
LABEL maintainer="Max Fierke <max@maxfierke.com>" \
      description="Build image for resumis"

ENV APP_HOME=/resumis \
    NODE_ENV=production \
    RAILS_ENV=production \
    RESUMIS_USER=resumis

# Build-time deps
RUN apk add --update --no-cache \
  build-base \
  linux-headers \
  nodejs \
  yarn \
  tzdata \
  gcompat \
  libxml2-dev \
  libxslt-dev \
  libgcc libstdc++ \
  git \
  postgresql-dev

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD ./Gemfile* $APP_HOME/
RUN bundle config --global frozen 1 \
  && bundle config build.nokogiri --use-system-libraries \
  && bundle config set without development test \
  && bundle install --retry 3 \
  # Remove unneeded files (cached *.gem, *.o, *.c)
  && rm -rf /usr/local/bundle/cache/*.gem \
  && find /usr/local/bundle/gems/ -name "*.c" -delete \
  && find /usr/local/bundle/gems/ -name "*.o" -delete

ADD ./package.json ./yarn.lock $APP_HOME/
RUN yarn install

ADD . $APP_HOME

# Precompile assets & bootsnap cache
RUN SECRET_KEY_BASE=IGNORE_ME_I_AM_A_BAD_KEY_BASE bundle exec rake assets:precompile && \
    rm -rf node_modules tmp/cache && \
    bundle exec bootsnap precompile --gemfile app/ lib/

# Runtime image
FROM ruby:3.2.2-alpine3.18
LABEL maintainer="Max Fierke <max@maxfierke.com>" \
      description="An API for your personal site & resume"
ENV APP_HOME=/resumis \
    NODE_ENV=production \
    RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true \
    RESUMIS_DEPLOY_ROOT=/resumis \
    RESUMIS_TENANCY_MODE=single \
    RESUMIS_USER=resumis \
    RUBY_YJIT_ENABLE=1 \
    PORT=5000 \
    WKHTMLTOPDF_PATH=/usr/bin/wkhtmltopdf

RUN mkdir -p $APP_HOME/shared/pids
RUN addgroup -g 1000 -S $RESUMIS_USER && \
    adduser -u 1000 -S $RESUMIS_USER -G $RESUMIS_USER -D

# Runtime deps
RUN apk add --update --no-cache \
  postgresql-client \
  file \
  imagemagick vips \
  tzdata \
  gcompat \
  # PDF stuff
  libintl \
  libcrypto3 libssl3 \
  ttf-dejavu ttf-droid ttf-freefont ttf-liberation \
  weasyprint

WORKDIR $APP_HOME
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder $APP_HOME $APP_HOME
RUN chown -R $RESUMIS_USER:$RESUMIS_USER $APP_HOME

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout log/puma.log && ln -sf /dev/stderr log/production.log

USER $RESUMIS_USER
EXPOSE 5000

RUN date -u > IMAGE_BUILD_TIME

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]
