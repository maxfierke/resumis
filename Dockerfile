FROM ruby:2.6.3-alpine
LABEL maintainer="Max Fierke <max@maxfierke.com>" \
      description="An API for your personal site & resume"

ENV APP_HOME=/resumis \
    RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RESUMIS_DEPLOY_ROOT=/resumis \
    RESUMIS_TENANCY_MODE=single \
    RESUMIS_USER=resumis \
    PORT=5000 \
    WKHTMLTOPDF_PATH=/usr/bin/wkhtmltopdf

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

RUN apk add --update --no-cache \
  libgcc libstdc++ libx11 glib libxrender libxext libintl \
  libcrypto1.1 libssl1.1 \
  ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family
RUN apk add --no-cache qt5-qtbase-dev wkhtmltopdf \
            --repository http://dl-3.alpinelinux.org/alpine/edge/community/

RUN mkdir -p $APP_HOME/shared/pids
WORKDIR $APP_HOME

ADD ./Gemfile* $APP_HOME/
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install -j$(getconf _NPROCESSORS_ONLN) --deployment --without test development

ADD . $APP_HOME

RUN SECRET_KEY_BASE=IGNORE_ME_I_AM_A_BAD_KEY_BASE bundle exec rake assets:precompile

RUN chown -R $RESUMIS_USER:$RESUMIS_USER $APP_HOME

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout log/unicorn.log \
  && ln -sf /dev/stderr log/production.log

USER $RESUMIS_USER

CMD [ "bundle", "exec", "unicorn", "-c", "config/unicorn.rb" ]
