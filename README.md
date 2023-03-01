# Resumis

Resumis is _Esperanto_ for "summarized". It's also an API and headless CMS for your
personal web presence, a CV generator, and JSON Resume provider.

### Requirements
* Ruby 3.2
* PostgreSQL 12+ with development dependencies
* Node.js 16+
* `wkhtmltopdf`. 0.12.5 recommended. Anything lower has known issues. Will use a binary specified by `WKHTMLTOPDF_PATH` or defaults to `/usr/local/bin/wkhtmltopdf`.
* `imagemagick`
* Redis 6.2+ for Sidekiq
* SMTP server (Production is configured to use SendGrid with credentials set by environmental variables `SENDGRID_USERNAME`, `SENDGRID_PASSWORD`, and `SENDGRID_DOMAIN`). It's only used by Devise for things like password resets, or confirmation emails. This is not a hard dependency and certainly not needed for development.

and others. See [Gemfile](Gemfile).

### Installation & Setup

* Clone the repo

  ```
  $ git clone git@github.com:maxfierke/resumis.git && cd resumis
  ```

* Install dependencies with Bundler

  ```
  $ bundle install
  ```
* See [Configuration](#Configuration) below and set any needed environment variables. In development, put them in `.env`.

* Create the database, run the migrations

  ```
  $ rake db:create db:migrate
  ```

* Run the app using [foreman](https://github.com/ddollar/foreman) or [forego](https://github.com/ddollar/forego)

  ```
  $ foreman start
  ```

* Create a user for yourself

  ```
  $ rake resumis:useradd -- -e {EMAIL} -p {PASSWORD} -f {FIRST_NAME} -l {LAST_NAME} -d {DOMAIN_NAME} --admin
  ```

* Go to [localhost:5000](http:/localhost:5000) to log into the management interface.

#### Configuration

Resumis-specific configuration can be done either through the `config/initializers/resumis.rb` initializer file, or through a some environmental variables.

* `SECRET_KEY_BASE` - Generate a value via `rake secret`.
* `RESUMIS_DEVISE_SECRET` - Generate a value via `rake secret`.
* `RESUMIS_MAIL_SENDER` - `From:` address for emails sent by Resumis (password resets, confirmations, etc.)
* `RESUMIS_CANONICAL_HOST` - Canonical hostname.

#### Deploying in Production (preferred)

* [Deploying with Docker](https://github.com/maxfierke/resumis/wiki/Running-Resumis-in-production-with-Docker)

## LICENSE

Apache License 2.0. See LICENSE
